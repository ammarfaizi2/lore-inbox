Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262654AbSJBWWs>; Wed, 2 Oct 2002 18:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262657AbSJBWWs>; Wed, 2 Oct 2002 18:22:48 -0400
Received: from gate.in-addr.de ([212.8.193.158]:22788 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S262654AbSJBWWq>;
	Wed, 2 Oct 2002 18:22:46 -0400
Date: Thu, 3 Oct 2002 00:29:58 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
Message-ID: <20021002222958.GN1202@marowsky-bree.de>
References: <Pine.GSO.4.21.0210011010380.4135-100000@weyl.math.psu.edu> <Pine.LNX.4.43.0210011650490.12465-100000@cibs9.sns.it> <20021001154808.GD126@suse.de> <20021001184225.GC29788@marowsky-bree.de> <1033520458.20284.46.camel@irongate.swansea.linux.org.uk> <20021002042434.GA13971@think.thunk.org> <1033565669.23682.10.camel@irongate.swansea.linux.org.uk> <20021002145434.GA1202@marowsky-bree.de> <1033578571.23758.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1033578571.23758.32.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-02T18:09:31,
   Alan Cox <alan@lxorguk.ukuu.org.uk> said:

> > I'd be fine if someone said "We'll have EVMS, md and DM in 2.6 and then sort
> > the mess in 2.7.", I'm just curious what the goal is. Right now, there's no
> > working code in 2.5 nor a vision, which is obviously a major bug.
> Look at history - if such a mess got in, it would never get sorted. 

Sounds like a good reason to do the cleanup immediately, then.

Deleting code, I can do that ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel
Research and Development, SuSE Linux AG
 
``Immortality is an adequate definition of high availability for me.''
	--- Gregory F. Pfister

