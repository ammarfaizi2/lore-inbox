Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVA2XYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVA2XYC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVA2XYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:24:02 -0500
Received: from alg138.algor.co.uk ([62.254.210.138]:21987 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261600AbVA2XWi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:22:38 -0500
Date: Sat, 29 Jan 2005 23:16:46 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.11-rc2-mm2] fix SERIAL_TXX9 dependencies
Message-ID: <20050129231646.GB18937@linux-mips.org>
References: <20050129131134.75dacb41.akpm@osdl.org> <20050129231255.GA3185@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129231255.GA3185@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 12:12:55AM +0100, Adrian Bunk wrote:

> > Changes since 2.6.11-rc2-mm1:
> >...
> > +mips-txx9-serieal-driver-rewrite.patch
> >...
> >  MIPS update
> >...
> 
> It seems the SERIAL_TXX9 dependencies are incorrect.

Wrong also.  Will fix in a minute.

  Ralf
