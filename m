Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSJTGay>; Sun, 20 Oct 2002 02:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262460AbSJTGay>; Sun, 20 Oct 2002 02:30:54 -0400
Received: from fmr01.intel.com ([192.55.52.18]:53994 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S262418AbSJTGax>;
	Sun, 20 Oct 2002 02:30:53 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC80D@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Justin T. Gibbs'" <gibbs@scsiguy.com>,
       "lkml (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: AIC7xxx driver build failure
Date: Sat, 19 Oct 2002 23:36:55 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The AIC 7xxx driver fails to build because the Makefile fails to
> > specify the correct include path to aicasm.
> > 
> > Justin, are you getting this?
> 
> No, because this bug doesn't exist in the latest version of the driver
> in my tree or the last set of patches I sent to Linus (a month ago??).

I could not find anywhere where it was reported, so will stop bugging. 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]
