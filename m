Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUFAVEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUFAVEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbUFAVEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:04:48 -0400
Received: from [213.146.154.40] ([213.146.154.40]:16102 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265240AbUFAVDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:03:13 -0400
Date: Tue, 1 Jun 2004 22:03:12 +0100 (BST)
From: jsimmons@pentafluge.infradead.org
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Eduard Bloch <edi@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
In-Reply-To: <20040530140350.GA2053@ucw.cz>
Message-ID: <Pine.LNX.4.56.0406012201240.23458@pentafluge.infradead.org>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de>
 <20040530111847.GA1377@ucw.cz> <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de>
 <20040530124353.GB1496@ucw.cz> <20040530135445.GA7571@zombie.inka.de>
 <20040530140350.GA2053@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 NO_REAL_NAME           From: does not include a real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > For examle, I wish to create two terminals with my system, using two
> > monitors (on dual-head video card), two keyboards and two mices. I can
> > do the first part (X manages it well) but not beeing able to use
> > different input devices for different users simply SUCKS.
> > But http://linuxconsole.sourceforge.net/ lets me hope.
> 
> I wrote most of the input handling in that project. It's what is in 2.6 now.

Yeap. The majority of the fbdev stuff went in from this project as well. 
The linuxconsole project is using the current input layer with multiple 
users with no problems.
