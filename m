Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRC3Tjz>; Fri, 30 Mar 2001 14:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRC3Tjp>; Fri, 30 Mar 2001 14:39:45 -0500
Received: from asbestos.brocade.com ([63.121.140.244]:25708 "EHLO
	mail.brocade.com") by vger.kernel.org with ESMTP id <S129346AbRC3Tjf>;
	Fri, 30 Mar 2001 14:39:35 -0500
Message-ID: <3AC4E1DE.7070005@muppetlabs.com>
Date: Fri, 30 Mar 2001 11:43:26 -0800
From: Amit D Chaudhary <amit@muppetlabs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac28 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Memory leak in the ramfs file system
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After testing with patch-2.4.2-ac28, the df commands works fine on a dir 
mounted as ramfs. Also, it recognizes the limits set, etc.

Thanks to David Gibson, Alan and others for making this available.

Regards
Amit

