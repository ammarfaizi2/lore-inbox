Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTICPAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTICPAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:00:34 -0400
Received: from ool-4353cae3.dyn.optonline.net ([67.83.202.227]:45487 "EHLO
	bigip.bigip.mine.nu") by vger.kernel.org with ESMTP id S262363AbTICPA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:00:28 -0400
Date: Wed, 3 Sep 2003 11:00:24 -0400
From: Mathieu Chouquet-Stringer <mchouque@online.fr>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Compiling latest 2.6 bk snapshot on Alpha
Message-ID: <20030903150024.GA18306@localhost>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@online.fr>,
	Marc Zyngier <mzyngier@freesurf.fr>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20030903143157.GA17699@localhost> <wrpznhm3pgg.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrpznhm3pgg.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 04:40:31PM +0200, Marc Zyngier wrote:
> Please check your binutils version. Here is the one I use, with great
> success :
> 
> maz@panther:/mnt/i386/linux-2.5$ alpha-linux-ld --version
> GNU ld version 2.13.90.0.18 20030121

Mine is: GNU ld version 2.14.90.0.5 20030722 Debian GNU/Linux

Looks like it's not that good... :-)

Thanks for the tip!
-- 
Mathieu Chouquet-Stringer              E-Mail : mchouque@online.fr
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
