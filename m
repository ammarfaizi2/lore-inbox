Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTKTQrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 11:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTKTQrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 11:47:13 -0500
Received: from main.gmane.org ([80.91.224.249]:18618 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262101AbTKTQrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 11:47:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: Announce: ndiswrapper
Date: Thu, 20 Nov 2003 16:47:07 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnbrps0b.dha.lunz@absolut.localnet>
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC3483.4060706@pobox.com> <20031120040034.GF19856@holomorphy.com> <3FBC5036.3020503@pobox.com>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jgarzik@pobox.com said:
> Who brought binary drivers into this?  And when I have ever advocated 
> binary drivers?
>
> ndiswrapper has one use IMHO (which was pointed out me in this 
> thread)... to assist in reverse engineering.

That may be your intention, but as soon as cards exist that can only be
made to work with ndis-wrapped drivers, you can be sure that the masses
won't wait for the reverse-engineering to be completed. So all the
nvidia-video-type problems _will_ start showing up in a big population
of laptops and such too.

Jason

