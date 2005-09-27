Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVI0FFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVI0FFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 01:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVI0FFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 01:05:37 -0400
Received: from metis.extern.pengutronix.de ([83.236.181.26]:54193 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S964809AbVI0FFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 01:05:36 -0400
Date: Tue, 27 Sep 2005 07:05:35 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Luke Yang <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ADI Blackfin porting for kernel-2.6.13
Message-ID: <20050927050535.GA19042@pengutronix.de>
References: <489ecd0c05091923336b48555@mail.gmail.com> <20050920071514.GA10909@plexity.net> <489ecd0c050922223736cf1548@mail.gmail.com> <20050924145102.GD28883@pengutronix.de> <489ecd0c05092618372a5993c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <489ecd0c05092618372a5993c5@mail.gmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 09:37:59AM +0800, Luke Yang wrote:
> We really don't have plan about Blackfin with a MMU now. So do you
> beleve it is necessary to change the name to arch/blackfin?

Hmm, as far as I know there are at least plans for variants with memory
protection units (but without virtual addressing), but anyway - why put
the mmu into the architecture name? If you use "blackfin" you are open
to everything and no non dsp guru has to guess what bf might be ;) 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

