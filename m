Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbSKTD6i>; Tue, 19 Nov 2002 22:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267625AbSKTD6i>; Tue, 19 Nov 2002 22:58:38 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:13014 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S265700AbSKTD6g>; Tue, 19 Nov 2002 22:58:36 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC/CFT] Separate obj/src dir
References: <20021119205430.GC15161@mars.ravnborg.org>
	<20021119202931.GA15161@mars.ravnborg.org>
	<Pine.LNX.3.95.1021119153545.6004A-100000@chaos.analogic.com>
	<20987.1037741860@passion.cambridge.redhat.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 20 Nov 2002 13:04:55 +0900
In-Reply-To: <20987.1037741860@passion.cambridge.redhat.com>
Message-ID: <buo1y5gnaxk.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:
> Of course it's a useful feature.

Definitely.  I already use home-grown scripts to maintain multiple
object-trees, with the sources symlinked to a single source tree,
because I generally maintain several different platforms simultaneously.

Having one source tree makes things _much_ easier, as I don't have to
keep track of changes in a bunch of separate trees (it also saves a bit
of space, which is nice)!

-Miles
-- 
Suburbia: where they tear out the trees and then name streets after them.
