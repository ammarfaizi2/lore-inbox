Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVKUWKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVKUWKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVKUWKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:10:30 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:7182 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S1751130AbVKUWK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:10:27 -0500
From: James Cloos <cloos@jhcloos.com>
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Re: make kernelrelease ignoring LOCALVERSION_AUTO
In-Reply-To: <20051121135420.GA10389@informatik.uni-freiburg.de> (Uwe
	Zeisberger's message of "Mon, 21 Nov 2005 14:54:20 +0100")
References: <m3acfz88qj.fsf@lugabout.cloos.reno.nv.us>
	<m3mzjy7sg2.fsf@lugabout.cloos.reno.nv.us>
	<20051121105353.GC6664@informatik.uni-freiburg.de>
	<20051121135420.GA10389@informatik.uni-freiburg.de>
Copyright: Copyright 2005 James Cloos
X-Hashcash: 1:23:051121:zeisberg@informatik.uni-freiburg.de::MpoZJ+DqMxlKrjPu:00000000000000000000000000Irj6
X-Hashcash: 1:23:051121:linux-kernel@vger.kernel.org::PydKwO4eO2ih6tco:000000000000000000000000000000000TbLw
X-Hashcash: 1:23:051121:torvalds@osdl.org::0uU2MrzcrsmPJ+Ci:00000000000000000000000000000000000000000000OfWM
X-Hashcash: 1:23:051121:sam@ravnborg.org::WcY7eRPyOcTrfpIc:073Rv
Date: Mon, 21 Nov 2005 17:10:13 -0500
Message-ID: <m3sltp4pq2.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Uwe" == Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

Uwe> With this fix the value of CONFIG_LOCALVERSION is appended to the
Uwe> output of `make kernelrelease`.  The git tag is *not* appended
Uwe> (yet) without a .config.

That works.

Thanks.

-JimC
