Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTFDDWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 23:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTFDDWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 23:22:10 -0400
Received: from rth.ninka.net ([216.101.162.244]:23680 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262636AbTFDDWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 23:22:09 -0400
Subject: Re: Linux 2.4.21-rc7
From: "David S. Miller" <davem@redhat.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, Jeff Garzik <jgarzik@pobox.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030603201434.GA803@ip68-0-152-218.tc.ph.cox.net>
References: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva>
	 <877k83xbbw.fsf@sycorax.lbl.gov> <20030603192711.GA22150@gtf.org>
	 <873cirx79r.fsf@sycorax.lbl.gov>
	 <20030603201434.GA803@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054697728.5514.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jun 2003 20:35:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-03 at 13:14, Tom Rini wrote:
> > gcc (GCC) 3.3 (Debian)
> > GNU ld version 2.14.90.0.4 20030523 Debian GNU/Linux
> 
> That would do it.

I don't trust anything past gcc-3.2.x on sparc and sparc64.
Use 3.3.x and later at your own peril.

-- 
David S. Miller <davem@redhat.com>
