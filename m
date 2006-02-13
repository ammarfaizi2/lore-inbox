Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWBMKwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWBMKwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWBMKwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:52:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:990 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932081AbWBMKwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:52:23 -0500
Date: Mon, 13 Feb 2006 11:52:22 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jerome.lacoste@gmail.com, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060213.104344.18941.atrey@ucw.cz>
References: <20060208162828.GA17534@voodoo> <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner> <200602090757.13767.dhazelton@enter.net> <43EC8F22.nailISDL17DJF@burner> <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com> <43F06220.nailKUS5D8SL2@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F06220.nailKUS5D8SL2@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This was true until ~ 2001, when Linux introduced unstable USB handling.

Even before that point it wasn't true, adding a new controller card
could always result in renumbering the previously existing controllers.

The key failure in your reasoning is that there is no definition of "the
same device", which would be both consistent and useful.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Not all rumors are as misleading as this one.
