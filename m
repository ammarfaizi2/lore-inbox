Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423496AbWJZNN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423496AbWJZNN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423498AbWJZNN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:13:26 -0400
Received: from ezoffice.mandriva.com ([84.14.106.134]:13829 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1423496AbWJZNNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:13:25 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
X-URL: <http://www.mandrivalinux.com/
References: <1161807069.3441.33.camel@dv>
	<1161808227.7615.0.camel@localhost.localdomain>
	<1161810392.3441.60.camel@dv> <20061025213355.GG23256@vasa.acc.umu.se>
	<1161817118.7615.34.camel@localhost.localdomain>
	<20061026032352.GI23256@vasa.acc.umu.se>
From: Thierry Vignaud <tvignaud@mandriva.com>
Organization: Mandriva
Date: Thu, 26 Oct 2006 15:13:23 +0200
In-Reply-To: <20061026032352.GI23256@vasa.acc.umu.se> (David Weinehall's message of "Thu, 26 Oct 2006 05:23:52 +0200")
Message-ID: <m2r6wvusng.fsf@vador.mandriva.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall <tao@acc.umu.se> writes:

> > > Personally I feel that no matter if they are legal or not, we
> > > should not cater to such drivers in the first place.  If it's
> > > trickier to use Windows API-drivers under Linux than to write a
> > > native Linux driver, big deal...  We don't want Windows-drivers.
> > > We want native drivers.
> > 
> > Neither taint nor _GPL are intended to stop people doing things
> > that, in the eyes of the masses, are stupid. The taint mark is
> > there to ensure that they don't harm the rest of us. The FSF view
> > of freedom is freedom to modify not freedom to modify in a manner
> > approved by some defining body.
> 
> Hence my use of the world "Personally".  It's my own opinion that we
> shouldn't support Windows API-drivers.  I don't think this has
> anything to do with the FSF view on freedom.  This has to do with
> the freedom to make a sound technical decision.

and your freedom to do whatever you want at home isn't restricted by
the tainting.
