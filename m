Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSL0NsI>; Fri, 27 Dec 2002 08:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbSL0NsI>; Fri, 27 Dec 2002 08:48:08 -0500
Received: from ppp3290-cwdsl.fr.cw.net ([62.210.105.37]:9676 "EHLO
	bouton.inet6-interne.fr") by vger.kernel.org with ESMTP
	id <S264673AbSL0NsI>; Fri, 27 Dec 2002 08:48:08 -0500
Date: Fri, 27 Dec 2002 14:56:22 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Athanasius <link@gurus.tf>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre21 - Dodgy DMA with PIIX4
Message-ID: <20021227145622.A21487@bouton.inet6-interne.fr>
Mail-Followup-To: Athanasius <link@gurus.tf>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20021227134551.GH1878@miggy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: =?iso-8859-1?Q?=3C20021227134551=2EGH1878=40miggy=2Eorg=3E=3B_from_link?=
 =?iso-8859-1?Q?=40gurus=2Etf_on_ven=2C_d=E9c_27=2C_2002_at_01:45:51_+000?=
 =?iso-8859-1?Q?0?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You configured your kernel with support for PIIX4 but your motherboard is
based on a VIA chipset...

Just disable support for PIIX4 and enable support for VIA82CXXX chipset

LB
