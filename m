Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVDKGys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVDKGys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 02:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVDKGys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 02:54:48 -0400
Received: from mail.avantwave.com ([210.17.210.210]:25737 "EHLO
	mail.avantwave.com") by vger.kernel.org with ESMTP id S261706AbVDKGyr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 02:54:47 -0400
Message-ID: <425A1F32.4020809@haha.com>
Date: Mon, 11 Apr 2005 14:54:42 +0800
From: Tomko <tomko@haha.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: question about execve()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to ask when a userprogram called in user space called 
execve("/bin/abc"....   will  this system call finally copy the code of 
/bin/abc into kernel space before kernel runs it or just leave the code 
in the userspace and run directly ?  If the system really copy the 
program into kernel space , why ?
Hope some one can tell me

Regards,
TOM
