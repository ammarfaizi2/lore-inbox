Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWBJORH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWBJORH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWBJORH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:17:07 -0500
Received: from thunk.org ([69.25.196.29]:13803 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932103AbWBJORE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:17:04 -0500
Date: Fri, 10 Feb 2006 09:16:51 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jengelh@linux01.gwdg.de, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210141651.GB18707@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	jengelh@linux01.gwdg.de, peter.read@gmail.com, mj@ucw.cz,
	matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
	jim@why.dont.jablowme.net
References: <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EC93A2.nailJEB1AMIE6@burner>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 02:22:42PM +0100, Joerg Schilling wrote:
> >
> > The struct stat->st_rdev field need to be stable too to comply to POSIX?
> 
> Correct.
> 

Chapter and verse, please?  

Can you please list the POSIX standard, section, and line number which
states that a particular device must always have the same st_rdev
across reboots, and hot plugs/unplugs?

Regards,

						- Ted
