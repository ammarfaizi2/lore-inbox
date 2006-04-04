Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWDDO2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWDDO2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 10:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWDDO2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 10:28:15 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:36738 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932212AbWDDO2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 10:28:14 -0400
Date: Tue, 04 Apr 2006 08:27:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.2 kernel
In-reply-to: <5XMAv-17T-11@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: tim tim <tictactoe.tim@gmail.com>
Message-id: <4432823B.4020606@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5XMAv-17T-11@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tim tim wrote:
> hello everybody.. i want to install 2.2 kernel .. and currently i have
> installed 2.6.10 kernel.. but when i compile 2.2 it says errors.. can
> some body plz tell me why.. or how to install that kernel..
> thankss

Your compiler is probably too new to build a 2.2 kernel. You likely need 
to use gcc 2.95. Also, a 2.2 kernel is unlikely to have a hope of 
running on a distribution made for 2.6.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

