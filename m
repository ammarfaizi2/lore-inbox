Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSHRMjB>; Sun, 18 Aug 2002 08:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSHRMjB>; Sun, 18 Aug 2002 08:39:01 -0400
Received: from capsi.xs4all.nl ([213.84.61.91]:22025 "HELO capsi.com")
	by vger.kernel.org with SMTP id <S314602AbSHRMjA>;
	Sun, 18 Aug 2002 08:39:00 -0400
Date: Sun, 18 Aug 2002 14:43:00 +0200
From: Alexander Kellett <lypanov@kde.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020818124300.GC20618@ezri.capsi>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
References: <200208171302.GAA07962@adam.yggdrasil.com> <20020817132201.GA3556@ezri.capsi> <1029613869.4809.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029613869.4809.26.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Disclaimer: My opinions do not necessarily represent those of KDE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 08:51:09PM +0100, Alan Cox wrote:
> On Sat, 2002-08-17 at 14:22, Alexander Kellett wrote:
> > So, pleeease Bartlomiej/Alan/Jens, whoever. Someone step up
> > to get most/some of Marcin' cleanup patches into 2.5 again.
> 
> Not interested. Its easier to go back to functionally correct code and
> do the job nicely than to fix the 2.5.3x code. Right now I'm working on
> Andre's current code in 2.4.20pre2-ac* starting off with only provably
> identical transforms between AndreCode and C and documenting it.

Better point, I realized my mistake right after reading Al's 
"tranformation" post and grasping the sense in it. Much better approach.  

Alex
