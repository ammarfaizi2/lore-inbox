Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWFNTWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWFNTWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 15:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWFNTWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 15:22:41 -0400
Received: from mail.gmx.de ([213.165.64.21]:63651 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750816AbWFNTWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 15:22:40 -0400
X-Authenticated: #14349625
Subject: RE: process starvation with 2.6 scheduler
From: Mike Galbraith <efault@gmx.de>
To: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       Radjendirane Codandaramane 
	<Radjendirane_Codandaramane@pmc-sierra.com>
In-Reply-To: <478F19F21671F04298A2116393EEC3D531CF15@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
References: <478F19F21671F04298A2116393EEC3D531CF15@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 21:26:19 +0200
Message-Id: <1150313179.7674.25.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-14 at 10:56 -0700, Kallol Biswas wrote:
> Yes, all 3 clients run on a Redhat 9 box.

Ok, what do the priorities and cpu distribution look like?

	-Mike

