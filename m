Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSHYMwX>; Sun, 25 Aug 2002 08:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSHYMwX>; Sun, 25 Aug 2002 08:52:23 -0400
Received: from meel.hobby.nl ([212.72.224.15]:51977 "EHLO meel.hobby.nl")
	by vger.kernel.org with ESMTP id <S316897AbSHYMwW>;
	Sun, 25 Aug 2002 08:52:22 -0400
Date: Sun, 25 Aug 2002 14:50:20 +0200
From: Toon van der Pas <toon@vanvergehaald.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] make localconfig
Message-ID: <20020825145020.A15128@vdpas.hobby.nl>
References: <20020824222735.B21265@vdpas.hobby.nl> <Pine.LNX.4.44.0208241522061.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208241522061.3234-100000@hawkeye.luckynet.adm>; from thunder@lightweight.ods.org on Sat, Aug 24, 2002 at 03:25:58PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2002 at 03:25:58PM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Sat, 24 Aug 2002, Toon van der Pas wrote:
> > > localconfig(9)	    Generating local configuration	    localconfig(9)
> > 
> > Yow!  The return of Aunt Tillie compiling a kernel!   :-)
> 
> Oh, please. This was not my intention.

My apologies.  I really couldn't resist..

> If you think it's a _deadly_bad_idea_to_do_ please tell me. It is,
> after all, just an RFC, means I request you to comment on this.
> I could even ask for kernel protection for the mice.

A serious question about your proposal then:
The .config file doesn't excusively contain information regarding
what hardware to support.  It also carries a lot of information about
the functionality and the optimzations the user wishes to incorporate
in his kernel.  How would localconfig deal with that?

Regards,
Toon.

BTW: Considering that you are not out of your mind (most of the
time), I admire your courage in bringing up this subject.  ;-)
-- 
 /"\                             |
 \ /     ASCII RIBBON CAMPAIGN   |  "Who is this General Failure, and
  X        AGAINST HTML MAIL     |   what is he doing on my harddisk?"
 / \
