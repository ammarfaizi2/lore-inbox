Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSCOKFb>; Fri, 15 Mar 2002 05:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289114AbSCOKFW>; Fri, 15 Mar 2002 05:05:22 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:27662 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S288748AbSCOKFH>; Fri, 15 Mar 2002 05:05:07 -0500
Date: Fri, 15 Mar 2002 11:05:02 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC -- lockup on machine if enabled
Message-ID: <20020315100502.GA12793@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200203132052.VAA08581@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203132052.VAA08581@harpo.it.uu.se>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Mikael Pettersson wrote:

> p.s. The update for 2.4.19-pre3 and the full kit for 2.4.18 are
> at <http://www.csd.uu.se/~mikpe/linux/patches/2.4/> as usual.

Does that also fix the "crashes on switch back from X11 to text (or
frame buffer) console" that's been around since 2.4.9 or 2.4.10, but not
before, that bites so many users of SuSE Linux 7.3?
de.comp.os.unix.linux.* has at least one report every week. SuSE shipped
kernel 2.4.10 with 7.3.

-- 
Matthias Andree
