Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSE3MVL>; Thu, 30 May 2002 08:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316613AbSE3MVK>; Thu, 30 May 2002 08:21:10 -0400
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:62989
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S316609AbSE3MVK>; Thu, 30 May 2002 08:21:10 -0400
Date: Thu, 30 May 2002 14:21:09 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange RAID2 behavier...
Message-ID: <20020530142109.A21537@bouton.inet6-interne.fr>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205301353210.16022-100000@kenny.worldonline.se> <Pine.LNX.4.21.0205301435390.20123-100000@kenny.worldonline.se> <20020530141225.A21429@bouton.inet6-interne.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On jeu, mai 30, 2002 at 02:12:25 +0200, Lionel Bouton wrote:
> On jeu, mai 30, 2002 at 02:37:53 +0200, me@vger.org wrote:
> > I made the md2 a linear raid of one drive, now I can stop the md3.
> > This means that for example making md0 and md3 will make md3 unstoppable,
> > has this bug already been reported?
> 
> This could be a bug/constraint in raidtools as said in mad raidtab:

s/mad/man/
"mad raidtab" could have been an accurate description of the problem though
:-)

> "the  parsing  code  isn't  overly bright".
