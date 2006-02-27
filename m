Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWB0Rzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWB0Rzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 12:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWB0Rzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 12:55:50 -0500
Received: from AMarseille-252-1-64-1.w86-193.abo.wanadoo.fr ([86.193.167.1]:39384
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751453AbWB0Rzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 12:55:50 -0500
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata PATA patch for 2.6.16-rc5
References: <1141054370.3089.0.camel@localhost.localdomain>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
From: Mathieu Chouquet-Stringer <ml2news@free.fr>
Organization: Uh?
Date: 27 Feb 2006 18:55:41 +0100
In-Reply-To: <1141054370.3089.0.camel@localhost.localdomain>
Message-ID: <m3k6bgk7oi.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox) writes:
> Some more fixes, and the ALi driver should now work although I've yet to
> finish the MWDMA work or finish chasing down the slow performance.

What does your roadmap look like now? Will you feed these patches to Jeff
Garzik when 2.6.17 opens or will you wait to have most of the stuff you
labelled "core features" completed?

-- 
Mathieu Chouquet-Stringer
