Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWBBMPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWBBMPL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWBBMPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:15:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48518 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750939AbWBBMPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:15:10 -0500
Date: Thu, 2 Feb 2006 13:15:09 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jim@why.dont.jablowme.net, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060202.121153.23653.atrey@ucw.cz>
References: <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner> <1138710764.17338.47.camel@juerg-t40p.bitron.ch> <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E1EA35.nail4R02QCGIW@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Now Linux likes to confuse people by trying to enforce a completely 
> incompatible access method.

Completely incompatible? For years, cdrecord works with it and it only
prints an utterly silly warning and also has a trivial bug in the scanning
code, causing it to stop too early.

> Note that I need to avoid unneeded efforts and for this reason, I need to wait
> 5 years until is is forseable that a recent incompatible change in Linux will
> survive long enough to spent time on it.

If this is reason, I will send you a patch fixing the trivial bugs and
annoyances, sparing you the work.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"I don't give a damn for a man that can only spell a word one way." -- M. Twain
