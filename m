Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263416AbTDXTgX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbTDXTgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:36:23 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8580
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263416AbTDXTgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:36:22 -0400
Subject: Re: [PATCH] aha1740 update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mzyngier@freesurf.fr
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <wrpk7dkt84r.fsf@hina.wild-wind.fr.eu.org>
References: <wrpk7dkt84r.fsf@hina.wild-wind.fr.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051210184.4005.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Apr 2003 19:49:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-24 at 13:03, Marc Zyngier wrote:
> The driver still lacks error handlers, due to my limited knowledge.
> It's been tested on both i386 and Alpha, both build-in and
> modular. I'll post my Alpha DMA patches as soon as I find some time to
> clean them up (it's a bit ugly at the moment...).
> 
> I'd appreciate any comment (patch is against 2.5.68).

The AHA1740 has firmware handled abort/reset handling. The "head in 
sand" kernel code is correct for once 8)


