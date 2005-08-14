Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbVHNAal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbVHNAal (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 20:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVHNAal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 20:30:41 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:57510 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751357AbVHNAal convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 20:30:41 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>,
       Stephen Pollei <stephen.pollei@gmail.com>,
       "Martin v." =?ISO-8859-1?Q?L=F6wis?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1123959201.11295.9.camel@mindpipe>
References: <42FDE286.40707@v.loewis.de>
	 <feed8cdd0508130935622387db@mail.gmail.com>
	 <1123958572.11295.7.camel@mindpipe>  <20050813184951.GA8283@carfax.org.uk>
	 <1123959201.11295.9.camel@mindpipe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Sun, 14 Aug 2005 01:57:45 +0100
Message-Id: <1123981065.14138.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >    I have "setxkbmap -symbols 'en_US(pc102)+gb'" in my ~/.xsession,
> > and « and » are available as AltGr-z and AltGr-x respectively.
> 
> Most keyboards don't have an AltGr key.

You must be an American. Most old the worlds keyboards have an AltGr
key. You'll find that US keyboards have two alt keys to avoid confusing
people (like one button mice ;)) but the right one is understood by the
X bindings to be "AltGr". Even though the US keyboard is apparently
lacking functionality its purely a text label issue

Alan

