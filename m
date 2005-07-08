Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262958AbVGHXOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbVGHXOF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVGHXJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:09:20 -0400
Received: from st.mff.cuni.cz ([195.113.20.8]:13790 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262963AbVGHXJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 19:09:01 -0400
Date: Sat, 9 Jul 2005 01:08:53 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.2 -- time passes faster; related to the acpi_register_gsi() call
Message-ID: <20050708230853.GA2040@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Alexander Nyberg <alexn@telia.com>,
	linux-kernel@vger.kernel.org
References: <20050708211203.GC382@ss1000.ms.mff.cuni.cz> <1120857908.25294.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120857908.25294.33.camel@localhost.localdomain>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Time started to pass faster with 2.6.12.2 (actually, it was 2.6.12-ck3
> > which is based on it). I have isolated the cause of the problem:
> 
> I bet you this fixes it (already in mainline)
> [...]

Indeed it does. Thanks.

Rudo.
