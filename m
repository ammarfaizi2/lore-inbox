Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318186AbSHMPwM>; Tue, 13 Aug 2002 11:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318189AbSHMPwM>; Tue, 13 Aug 2002 11:52:12 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:37896 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318186AbSHMPwM>;
	Tue, 13 Aug 2002 11:52:12 -0400
Date: Tue, 13 Aug 2002 18:04:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg Banks <gnb@alphalink.com.au>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
Message-ID: <20020813180415.B1357@mars.ravnborg.org>
Mail-Followup-To: Greg Banks <gnb@alphalink.com.au>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
References: <20020808151432.GD380@cadcamlab.org> <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu> <20020808164742.GA5780@cadcamlab.org> <20020809041543.GA4818@cadcamlab.org> <3D53D50D.7FA48644@alphalink.com.au> <20020809161046.GB687@cadcamlab.org> <3D579629.32732A73@alphalink.com.au> <20020812154721.GA761@cadcamlab.org> <3D587BA7.1D640926@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D587BA7.1D640926@alphalink.com.au>; from gnb@alphalink.com.au on Tue, Aug 13, 2002 at 01:23:19PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 01:23:19PM +1000, Greg Banks wrote:
> 
> 977    missing-experimental-tag
> 113    spurious-experimental-tag
> 145    variant-experimental-tag
> 30     inconsistent-experimental-tag
> 13     missing-obsolete-tag
> 41     spurious-obsolete-tag
> 25     variant-obsolete-tag
How about extending the language (side effect) to automagically append
(EXPERIMENTAL) or (OBSOLETE) to the menu line, if dependent on
those special tags?

	Sam
