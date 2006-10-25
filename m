Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbWJYWzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbWJYWzX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 18:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWJYWzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 18:55:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13264 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161065AbWJYWzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 18:55:22 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Weinehall <tao@acc.umu.se>
Cc: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061025213355.GG23256@vasa.acc.umu.se>
References: <1161807069.3441.33.camel@dv>
	 <1161808227.7615.0.camel@localhost.localdomain>
	 <1161810392.3441.60.camel@dv>  <20061025213355.GG23256@vasa.acc.umu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Oct 2006 23:58:38 +0100
Message-Id: <1161817118.7615.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-25 am 23:33 +0200, ysgrifennodd David Weinehall:
> Personally I feel that no matter if they are legal or not, we should not
> cater to such drivers in the first place.  If it's trickier to use
> Windows API-drivers under Linux than to write a native Linux driver,
> big deal...  We don't want Windows-drivers.  We want native drivers.

Neither taint nor _GPL are intended to stop people doing things that, in
the eyes of the masses, are stupid. The taint mark is there to ensure
that they don't harm the rest of us. The FSF view of freedom is freedom
to modify not freedom to modify in a manner approved by some defining
body.

Alan

