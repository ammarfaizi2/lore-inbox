Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264875AbTLKK5z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 05:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbTLKK5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 05:57:55 -0500
Received: from AGrenoble-101-1-4-17.w217-128.abo.wanadoo.fr ([217.128.202.17]:51085
	"EHLO awak") by vger.kernel.org with ESMTP id S264875AbTLKK5v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 05:57:51 -0500
Subject: RE: Linux GPL and binary module exception clause?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Maciej Zenczykowski <maze@cela.pl>,
       David Schwartz <davids@webmaster.com>,
       Jason Kingsland <Jason_Kingsland@hotmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10312101449260.3805-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10312101449260.3805-100000@master.linux-ide.org>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1071140217.6273.134.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Dec 2003 11:56:58 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 10/12/2003 à 23:59, Andre Hedrick a écrit :
> Ingo,
> 
> I suggest asking FSF how they play with GPL+another license.
> They will tell you GPL can not co-exist, period.

Think of it as a fork.
I own a piece of code I just made. So far I can license it the way I
want, OK ?
So I fork it, license one branch under the GPL and license the other
branch under a proprietary license. Voilà, it's dual-licensed !
When integrated to the linux kernel, it's technically fully GPLed, even
if called "proprietary/GPL" in the header file.

Of course, contributors to my work are free to tell me "I want my
patches to your code only for the GPL version", but generally they
won't, so I can integrate them back to the proprietary code. Pending
good legal advice, of course.

It it clearer ?

	Xav

