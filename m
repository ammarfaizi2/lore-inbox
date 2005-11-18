Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVKRPZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVKRPZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVKRPZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:25:34 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:26242 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932070AbVKRPZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:25:34 -0500
Date: Fri, 18 Nov 2005 16:25:19 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
cc: Giuliano Pochini <pochini@shiny.it>, alex@alexfisher.me.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jeff V. Merkey" <jmerkey@utah-nac.org>,
       Michael Buesch <mbuesch@freenet.de>
Subject: Re: Would I be violating the GPL?
In-Reply-To: <20051118151932.GH9488@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.61.0511181624510.3917@yvahk01.tjqt.qr>
References: <XFMail.20051102104916.pochini@shiny.it>
 <Pine.LNX.4.61.0511102002160.17092@yvahk01.tjqt.qr> <20051110191244.GG9488@csclub.uwaterloo.ca>
 <Pine.LNX.4.61.0511172221580.4792@yvahk01.tjqt.qr> <20051118151932.GH9488@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Whyever is anything calling cc1plus when the file appear to all be .c?

The makefile explicitly adds "-x c++" for this one.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
