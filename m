Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVBOO3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVBOO3T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 09:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVBOO3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 09:29:19 -0500
Received: from static64-74.dsl-blr.eth.net ([61.11.64.74]:59653 "EHLO
	linmail.globaledgesoft.com") by vger.kernel.org with ESMTP
	id S261727AbVBOO3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 09:29:16 -0500
Message-ID: <421206B5.1080204@globaledgesoft.com>
Date: Tue, 15 Feb 2005 19:57:01 +0530
From: krishna <krishna.c@globaledgesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ijc@hellion.org.uk
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What is the Purpose of GPIO Controller.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

    Thank you very much.
    My doubt is,
    I have a board here where all lines to the peripherals are highly 
multiplexed and
    I had to configure these lines. Now my Wireless Ethernet Driver has 
a conflict with
    the audiocodec driver. What I mean is, if I load the WLAN driver and 
try to load the
    audiocodec driver next, the audiocodec driver is not responding.

    I traced the bug to be sharing of GPIO Lines.

    Form your mail I understand GPIO controller serves some Hardware 
designers purpose.
    But what _purpose_ is it serving a _programmer_.

Regards,
Krishna Chaitanya
