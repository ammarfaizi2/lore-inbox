Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132642AbRDOU7f>; Sun, 15 Apr 2001 16:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbRDOU7Z>; Sun, 15 Apr 2001 16:59:25 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:18330 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S132326AbRDOU7N>; Sun, 15 Apr 2001 16:59:13 -0400
Message-ID: <3ADA0B50.8030301@muppetlabs.com>
Date: Sun, 15 Apr 2001 13:57:52 -0700
From: Amit D Chaudhary <amit@muppetlabs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Can't free the ramdisk (initrd, pivot_root)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the same topic, I have not found any change in free memory reported before 
and after the ioctl call. Though umount /initrd does free around 2 MB.


Amit

