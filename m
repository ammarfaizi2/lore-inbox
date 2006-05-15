Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWEOXHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWEOXHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWEOXHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:07:44 -0400
Received: from animx.eu.org ([216.98.75.249]:13978 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1750734AbWEOXHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:07:43 -0400
Date: Mon, 15 May 2006 19:13:04 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFT] major libata update
Message-ID: <20060515231304.GC4699@animx.eu.org>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20060515170006.GA29555@havoc.gtf.org> <20060515230256.GB4699@animx.eu.org> <4469081D.7080608@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4469081D.7080608@garzik.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Wakko Warner wrote:
> >How about PATA?  Specifically intel's IDE chip.  I have a machine that I 
> >can
> >blow the hard drive away if I want to.
> 
> Always helpful.  ata_piix should support Intel PATA controllers, modulo 
> some bugs that Alan is fixing / has fixed.  If your PCI ID isn't listed, 
> you will have to add it, and an associated info entry.  Again, take a 
> look at Alan's libata PATA patches for guidance.

Do I need his patches as well?  If so, where do I retrieve them?  I lost the
url for it.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
