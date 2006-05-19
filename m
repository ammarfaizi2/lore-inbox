Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWESOlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWESOlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 10:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWESOlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 10:41:04 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:42390 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932329AbWESOlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 10:41:03 -0400
X-ME-UUID: 20060519144102420.00FAC1C0164E@mwinf0507.wanadoo.fr
Subject: Re: replacing X Window System !
From: Xavier Bestel <xavier.bestel@free.fr>
To: David Greaves <david@dgreaves.com>
Cc: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       linux cbon <linuxcbon@yahoo.fr>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <446DD75D.8050203@dgreaves.com>
References: <20060518172827.73908.qmail@web26601.mail.ukl.yahoo.com>
	 <446D8F36.3010201@aitel.hist.no> <446DA746.50506@lumumba.uhasselt.be>
	 <446DD75D.8050203@dgreaves.com>
Content-Type: text/plain
Message-Id: <1148049652.26628.128.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 19 May 2006 16:40:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 16:34, David Greaves wrote:
> Panagiotis Issaris wrote:
> > Hi,
> >
> > Helge Hafting wrote:
> >
> >> [...]
> >> The problem with writing those 3D drivers is not complexity
> >> or "historic baggage" in the X codebase.  It is the fact that
> >> only the vendors know how the cards work, and most of them
> >> won't tell us.
> >>
> >> To which the solution is:  buy the cards that work, and screw the rest. 
> >
> > Just out of curiosity: Do you know any currently sold cards that support
> > XVideo, OpenGL and for which open source drivers are available?
> >
> > With friendly regards,
> > Takis
> Almost all ATI cards :)

BEWARE !! None of the "Avivo" series (ATI X1000 and later) will work.
Only the readon (Radeon 7xxx, Radeon 8xxx, Radeon 9xxx, X600, X700,
X800) have drivers.

See DRI homepage for more information.

	Xav


