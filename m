Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318229AbSHDTe5>; Sun, 4 Aug 2002 15:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSHDTe5>; Sun, 4 Aug 2002 15:34:57 -0400
Received: from pD9E2319C.dip.t-dialin.net ([217.226.49.156]:10444 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318229AbSHDTe5>; Sun, 4 Aug 2002 15:34:57 -0400
Date: Sun, 4 Aug 2002 13:38:17 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Pavel Machek <pavel@ucw.cz>
cc: Thunder from the hill <thunder@ngforever.de>,
       Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.30 ACPI: fixing compilation
In-Reply-To: <20020804192210.GA31471@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0208041337470.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 4 Aug 2002, Pavel Machek wrote:
> It was broken before so I left it broken. Second CPU will probably
> kill it fast enough not to corrupt data too badly.

I meant, depending the code on !CONFIG_SMP.

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

