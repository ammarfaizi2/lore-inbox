Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136388AbRD2WB6>; Sun, 29 Apr 2001 18:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136387AbRD2WBh>; Sun, 29 Apr 2001 18:01:37 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:57888 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S136386AbRD2WBe>; Sun, 29 Apr 2001 18:01:34 -0400
Date: Mon, 30 Apr 2001 01:01:15 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: Duncan Gauld <duncan@gauldd.freeserve.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: question regarding cpu selection
Message-ID: <20010430010115.L3529@niksula.cs.hut.fi>
In-Reply-To: <01042919075101.01335@pc-62-31-91-135-dn.blueyonder.co.uk> <20010429145608.A703@better.net> <20010429223641.K3529@niksula.cs.hut.fi> <01042921284803.01335@pc-62-31-91-135-dn.blueyonder.co.uk> <20010429233250.G3682@niksula.cs.hut.fi> <20010429231312.I24579@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010429231312.I24579@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Sun, Apr 29, 2001 at 11:13:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 11:13:12PM +0200, you [Erik Mouw] claimed:
> On Sun, Apr 29, 2001 at 11:32:51PM +0300, Ville Herva wrote:
> > On Sun, Apr 29, 2001 at 09:28:48PM -0400, you [Duncan Gauld] claimed:
> > > I would supply a patch, but I don't know how to write such a thing :)
> > 
> > It seems Erik Mouw already submitted a patch, altough I agree that "Celeron
> > II" might be a better name for the thing than "Celeron (Coppermine)".
> 
> So what about this one? This time I had to change Configure.help and
> setup.c as well to reflect the changes in config.in :)

Hmm. I just checked Intel's web site (should've done so earlier), and it
appears that Intel still dubs the new revision as "Celeron", although I'm
sure it was introduced as CeleronII in some sources (try
http://www.google.com/search?q=CeleronII). So I'll just have admit that your
first patch was technically correct, and I was wrong. Sorry for the
inconvenience.

I still think "Celeron II" is clearer, but heaven knows what Intel will sell
by that name three years from now (just think of i860).


-- v --

v@iki.fi
