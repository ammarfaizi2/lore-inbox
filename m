Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWBVHl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWBVHl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 02:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWBVHl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 02:41:57 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:15503 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S932214AbWBVHlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 02:41:55 -0500
Message-ID: <43FC1624.8090607@qazi.f2s.com>
Date: Wed, 22 Feb 2006 07:43:32 +0000
From: Asfand Yar Qazi <ay0106@qazi.f2s.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060217)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 'vga=' parameter wierdness
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'Scuse my noobness, but when I supply the following parameter to the arguments 
  of my kernel through GRUB, I get an 'undefined mode' error:

vga=0164

But then, when the prompt comes up asking me which mode I want I type in:

0164

and I get the required mode!

What's happening?  On 2.4 kernel, I used to boot with vga=0x0a (which is the 
same mode as 0164) and it would boot fine.  Not anymore...

Help?
