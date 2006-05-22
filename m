Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWEVP1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWEVP1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWEVP1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:27:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57492 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750937AbWEVP1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:27:24 -0400
Subject: Re: [IDEA] Poor man's UPS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: Jan Knutar <jk-lkml@sci.fi>, Pau Garcia i Quiles <pgquiles@elpauer.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060522151303.GA4538@hermes.uziel.local>
References: <200605212131.47860.pgquiles@elpauer.org>
	 <20060521224012.GB30855@hermes.uziel.local>
	 <200605221604.16043.jk-lkml@sci.fi>
	 <20060522151303.GA4538@hermes.uziel.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 22 May 2006 16:40:58 +0100
Message-Id: <1148312458.17376.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Guess the chosen terminology was a bit unlucky, with "completely" I
> meant in fact "completely, within the constraints implied by the
> technology used" ; ) So no deep discharge, but "as far as it gets
> without killing the battery".

Lead acid batteries should be kept well charged to avoid sulphation and
always full charged when recharging, preferably using a charger that
will do proper three step charging. "Cycling" a lead acid battery is a
great way to destroy it.

Alan

