Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751811AbWCOW5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWCOW5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWCOW5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:57:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:22756 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751811AbWCOW5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:57:17 -0500
Date: Wed, 15 Mar 2006 23:57:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Arjan van de Ven <arjan@infradead.org>,
       j4K3xBl4sT3r <jakexblaster@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Which kernel is the best for a small linux system?
In-Reply-To: <20060313182725.GA31211@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0603152355460.20859@yvahk01.tjqt.qr>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com>
 <1142237867.3023.8.camel@laptopd505.fenrus.org> <20060313182725.GA31211@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On another denx.de page I found this summary (so you do not have to
>visit the page):
># slow to build: 2.6 takes 30...40% longer to compile

A side effect of all the new optimizations that went into gcc since 2.95,
I would say.


Jan Engelhardt
-- 
