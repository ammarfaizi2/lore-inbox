Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTLLV23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTLLV1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:27:46 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:63641
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S262038AbTLLV1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:27:31 -0500
Date: Fri, 12 Dec 2003 16:35:45 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 and IDE "geometry"
Message-ID: <20031212163545.A26866@animx.eu.org>
References: <20031212131704.A26577@animx.eu.org> <20031212194439.GB11215@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20031212194439.GB11215@win.tue.nl>; from Andries Brouwer on Fri, Dec 12, 2003 at 08:44:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is there anyway to get kernel 2.6 to use the geometry
> > the bios has for an IDE drive?
> 
> The kernel does not use any geometry.

This I know, however, the kernel in the past has the geometry from the BIOS

> > I have a installation setup that installs a non-linux os and I partition the
> > drive under linux.  In 2.4 this has worked flawlessly, however, 2.6 reports
> > as # cylinders/16 heads/63 sectors.
> 
> Aha. So your real question is:
> "Is there any way to get *fdisk to use my favorite geometry?"
> The answer is: all common fdisk versions allow you to set the geometry.

I realize this too, however, I need it to happen automatically and be
consistent with the bios idea of the disk.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
