Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTERXzi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 19:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbTERXzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 19:55:38 -0400
Received: from air-2.osdl.org ([65.172.181.6]:35048 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262273AbTERXzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 19:55:37 -0400
Date: Sun, 18 May 2003 17:03:30 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Gregoire Favre <greg@magma.unil.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe ide-floppy crash system in 2.5.69-ac1
Message-Id: <20030518170330.1e20cbfc.rddunlap@osdl.org>
In-Reply-To: <20030518144858.GD29806@magma.unil.ch>
References: <20030518144858.GD29806@magma.unil.ch>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003 16:48:58 +0200 Gregoire Favre <greg@magma.unil.ch> wrote:

| Hallo,
| 
| just wanted to try 2.5.69-ac1, but as soon as I try
| modprobe ide-floppy my system completely crash :-(
| 
| Should I provide other info?

Hi,

There have been a few other problems reported, including some
by you in 2.5.69 and by Udo Steinberg, also in 2.5.69.
Udo's report is at
http://marc.theaimsgroup.com/?l=linux-kernel&m=105266660108932&w=2
(see the attachments).

I don't see any of these in the kernel bugzilla though,
so I'd suggest entering one there, please.

http://bugzilla.kernel.org
or http://bugme.osdl.org

--
~Randy
