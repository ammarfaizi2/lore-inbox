Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVELUGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVELUGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 16:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVELUGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 16:06:35 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:47451 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262052AbVELUGe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 16:06:34 -0400
X-ME-UUID: 20050512200633272.429FA1C0017D@mwinf0503.wanadoo.fr
Subject: Re: Enhanced Keyboard Driver
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alan Bryan <icemanind@yahoo.com>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050512194805.52183.qmail@web53101.mail.yahoo.com>
References: <20050512194805.52183.qmail@web53101.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 12 May 2005 22:06:21 +0200
Message-Id: <1115928381.13672.10.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 12 mai 2005 à 12:48 -0700, Alan Bryan a écrit :
> > 
> > What do you actually want to do?
> > 
> specifically, I am trying to write a program similar
> to the old Sidekick program of the DOS days. A
> "daemon", if you will, that will popup on the screen
> when a predetermined series of keystrokes are hit. The
> program will then do various things, like record/play
> macros, calculator, calendar, programmer's guide, etc
> etc...

Then a keyboard driver isn't the good solution. You'd better write a
userspace app which uses the XTEST extension.

	Xav


