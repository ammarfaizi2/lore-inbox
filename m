Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264033AbUDFWQn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264036AbUDFWQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:16:43 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:12482 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264033AbUDFWQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:16:42 -0400
Date: Tue, 6 Apr 2004 23:14:03 +0100
From: Dave Jones <davej@redhat.com>
To: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
Cc: Bjoern Michaelsen <bmichaelsen@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Message-ID: <20040406221403.GB10142@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>,
	Bjoern Michaelsen <bmichaelsen@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20040406031949.GA8351@lord.sinclair> <200404062304.12089.volker.hemmann@heim10.tu-clausthal.de> <20040406210811.GA10142@redhat.com> <200404070001.35514.volker.hemmann@heim10.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404070001.35514.volker.hemmann@heim10.tu-clausthal.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 12:01:35AM +0200, Hemmann, Volker Armin wrote:

 > ok, I was a little confused so:
 > vanilla 2.6.5+this patch: old testgart garbeling problem again
 > patched 2.6.5-rc3+this patch: everything fine
 > vanilla 2.6.5+agpgart-2004-04-06.diff+ this patch: everything fine, too

Ah yes, sorry I should've mentioned you need the other parts.
This is as expected. I'll push this out. Thanks for your
testing, and your patience 8-)

		Dave

