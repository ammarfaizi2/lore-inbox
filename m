Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267405AbTAVJmg>; Wed, 22 Jan 2003 04:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267407AbTAVJmg>; Wed, 22 Jan 2003 04:42:36 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:44430 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267405AbTAVJmf>; Wed, 22 Jan 2003 04:42:35 -0500
Date: Wed, 22 Jan 2003 10:51:05 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: kernel param and KBUILD_MODNAME name-munging mess
Message-ID: <20030122105105.Z628@nightmaster.csn.tu-chemnitz.de>
References: <200301201341.OAA23795@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200301201341.OAA23795@harpo.it.uu.se>; from mikpe@csd.uu.se on Mon, Jan 20, 2003 at 02:41:03PM +0100
X-Spam-Score: -2.5 (--)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18bHXq-0003Xc-00*wvC4ZBi8Lt.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 02:41:03PM +0100, Mikael Pettersson wrote:
> Booting kernel 2.5.59 with the "-s" kernel boot parameter
> doesn't get you into single-user mode like it should.

Try using "s" instead. This works since ever. I didn't even know,
that the other option exists, too.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
