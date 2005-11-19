Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVKSUap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVKSUap (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVKSUap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:30:45 -0500
Received: from smtp3.nextra.sk ([195.168.1.142]:1297 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1750789AbVKSUao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:30:44 -0500
Message-ID: <437F8B7E.5050805@rainbow-software.org>
Date: Sat, 19 Nov 2005 21:30:54 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Does Linux support powering down SATA drives?
References: <437F63C1.6010507@perkel.com> <200511191900.12165.s0348365@sms.ed.ac.uk> <1132431907.19692.15.camel@localhost.localdomain> <200511192021.40922.s0348365@sms.ed.ac.uk>
In-Reply-To: <200511192021.40922.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> My mistake, I was unaware of the difference between "Suspend" and (presumably) 
> "Sleep". I've tried the latter without success on a Maxtor 120G here, does 
> this work for anybody else (hdparm -Y)?

I've tried hdparm -Y - only once - the drive went to sleep mode and did 
not came back, I had to use reset button.

-- 
Ondrej Zary
