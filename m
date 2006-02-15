Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030597AbWBOC21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030597AbWBOC21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 21:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030598AbWBOC21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 21:28:27 -0500
Received: from webmail.terra.es ([213.4.149.12]:63678 "EHLO
	csmtpout1.frontal.correo") by vger.kernel.org with ESMTP
	id S1030597AbWBOC21 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 21:28:27 -0500
Date: Wed, 15 Feb 2006 03:32:05 +0100 (added by postmaster@terra.es)
From: <grundig@teleline.es>
To: "D. Hazelton" <dhazelton@enter.net>
Cc: galibert@pobox.com, rob@landley.net, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060215032802.55d7cb58.grundig@teleline.es>
In-Reply-To: <200602142119.42981.dhazelton@enter.net>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
	<200602141751.02153.rob@landley.net>
	<20060214232401.GA83161@dspnet.fr.eu.org>
	<200602142119.42981.dhazelton@enter.net>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 14 Feb 2006 21:19:42 -0500,
"D. Hazelton" <dhazelton@enter.net> escribió:

> However it is a C++ application, and I don't know about other people, but for 
> various historic reasons I'd rather use C for a command-line application. And 

This doesn't have any sense at all, there's no reason why C++ is not a valid
language for command line apps (like C is perfect...hint: python/perl/etc
are famous languages to write command line scripts because of a reason). There's
lot of serious software written in C++ (dpkg, for one).

C in fact was created to write a operative system in a time when writting things
in asm was the rule. Looking back at the history and learning the lesson from
C, common sense tells me that there're lots of problems that can be solved in a
much easier way with C++ just like C vs asm in the 60-70's....
