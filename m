Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423014AbWBBG3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423014AbWBBG3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 01:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423016AbWBBG3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 01:29:36 -0500
Received: from atpro.com ([12.161.0.3]:25866 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1423014AbWBBG3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 01:29:35 -0500
Date: Thu, 2 Feb 2006 01:28:41 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: j@bitron.ch, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060202062840.GI5501@mail>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	j@bitron.ch, mrmacman_g4@mac.com, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
	James@superbug.co.uk, acahalan@gmail.com
References: <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner> <1138710764.17338.47.camel@juerg-t40p.bitron.ch> <43DF6812.nail3B44TLQOP@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43DF6812.nail3B44TLQOP@burner>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/06 02:37:22PM +0100, Joerg Schilling wrote:
> Juerg Billeter <j@bitron.ch> wrote:
> 
> > > So why do people try to convince me that there is a need to avoid the standard 
> > > SCSI protocol stack because a PC might have only ATAPI? 
> > > 
> > > Major OS implementations use a unique view on SCSI (MS-win [*], FreeBSD, Solaris, 
> > > ...). Why do people believe that Linux needs to be different? What does it buy 
> > > you to go this way?
> >
> > Why do you believe that Linux needs to do the same as every other OS?
> 
> Why do you believe that Linux needs to be worse than other OS?
> 

Every other method to access those devices uses the device name, i.e.
mount, fsck, etc, so why should cdrecord be different?

> Jörg


Jim.
