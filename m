Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUCQTI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 14:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUCQTI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 14:08:27 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:6842 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261951AbUCQTIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 14:08:25 -0500
Date: Wed, 17 Mar 2004 20:08:22 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jblaw@lug-owl.de>, Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/44] Add DEC LK201/LK401 keyboard support
In-Reply-To: <10794467773966@twilight.ucw.cz>
Message-ID: <Pine.LNX.4.55.0403172000530.14525@jurand.ds.pg.gda.pl>
References: <10794467773966@twilight.ucw.cz>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004, Vojtech Pavlik wrote:

> You can pull this changeset from:
> 	bk://kernel.bkbits.net/vojtech/input
> 
> ===================================================================
> 
> ChangeSet@1.1608.56.5, 2004-03-03 17:16:24+01:00, jbglaw@lug-owl.de
>   input: Add DEC LK201/LK401 keyboard support

 Jan-Benedict, are you going to maintain this driver or should I do that?  
There's a lot of functionality missing comparing to the old one and I want
to see it merged.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
