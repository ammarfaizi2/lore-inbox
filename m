Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbVLaAm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVLaAm2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVLaAm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:42:28 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:31628 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750834AbVLaAm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:42:28 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sat, 31 Dec 2005 01:42:18 +0100
Subject: Re: Howto set kernel makefile to use particular gcc
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: Chris White <chriswhite@gentoo.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       linux-kernel@vger.kernel.org
In-reply-to: <3AEC1E10243A314391FE9C01CD65429B2239CF@mail.esn.co.in>
References: <3AEC1E10243A314391FE9C01CD65429B2239CF@mail.esn.co.in>
Message-Id: <20051231004216.6851222AEE7@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mukund JB. wrote:
>Thanks for that.
>I will test it
I only add some information -- in FC4, there is compat-gcc-32 package, so you
may simply do `make CC=gcc32'.

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E

