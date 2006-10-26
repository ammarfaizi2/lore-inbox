Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWJZDX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWJZDX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 23:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWJZDX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 23:23:58 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:1729 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S932253AbWJZDX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 23:23:57 -0400
Date: Thu, 26 Oct 2006 05:23:52 +0200
From: David Weinehall <tao@acc.umu.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
Message-ID: <20061026032352.GI23256@vasa.acc.umu.se>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
References: <1161807069.3441.33.camel@dv> <1161808227.7615.0.camel@localhost.localdomain> <1161810392.3441.60.camel@dv> <20061025213355.GG23256@vasa.acc.umu.se> <1161817118.7615.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161817118.7615.34.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 11:58:38PM +0100, Alan Cox wrote:
> Ar Mer, 2006-10-25 am 23:33 +0200, ysgrifennodd David Weinehall:
> > Personally I feel that no matter if they are legal or not, we should not
> > cater to such drivers in the first place.  If it's trickier to use
> > Windows API-drivers under Linux than to write a native Linux driver,
> > big deal...  We don't want Windows-drivers.  We want native drivers.
> 
> Neither taint nor _GPL are intended to stop people doing things that, in
> the eyes of the masses, are stupid. The taint mark is there to ensure
> that they don't harm the rest of us. The FSF view of freedom is freedom
> to modify not freedom to modify in a manner approved by some defining
> body.

Hence my use of the world "Personally".  It's my own opinion that we
shouldn't support Windows API-drivers.  I don't think this has anything
to do with the FSF view on freedom.  This has to do with the freedom to
make a sound technical decision.


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
