Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266192AbUALQrQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUALQrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:47:16 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:4357 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S266192AbUALQrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:47:15 -0500
Date: Mon, 12 Jan 2004 17:21:23 +0100
From: DervishD <raul@pleyades.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP or UP???
Message-ID: <20040112162123.GG18408@DervishD>
References: <200401121211.i0CCBg5u006677@harpo.it.uu.se> <20040112122538.GD18408@DervishD> <4002A296.4010305@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4002A296.4010305@aitel.hist.no>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Helge :)

 * Helge Hafting <helgehaf@aitel.hist.no> dixit:
> >    Excuse my ignorance but: why a UP system needs the MP table? Why
> >the I/O-APIC needs anything related with multiprocessor in an UP
> >system?. I lost my way on hardware back in the 486, I think...
> The MP table tells the kernel details about that I/O-APIC.
> (Advanced Programmable Interrupt Controller).
> This isn't really about SMP, but every SMP board has
> one or more APICs.  They have to.  It is optional
> on a uniprocessor board, but it is nice to have as it
> gives lower interrupt latency.

    Thanks a lot for the information :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
