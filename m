Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbVDHJ3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbVDHJ3m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 05:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVDHJ3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 05:29:42 -0400
Received: from mail.avantwave.com ([210.17.210.210]:54748 "EHLO
	mail.avantwave.com") by vger.kernel.org with ESMTP id S262773AbVDHJ3l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 05:29:41 -0400
Message-ID: <42564F02.9010701@avantwave.com>
Date: Fri, 08 Apr 2005 17:29:38 +0800
From: Ko Yu Ting <tomko@avantwave.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: question about init procedure in linux kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I would like to ask why nfs and devfs are initiated in the function 
filesystem_setup() rather than do in the function do_init_calls()? as i 
see other filesystem like ext2 are initiated there by init_ext2_fs().  
Can anyone tell me why ?


Regards,
TOM
