Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264620AbTE1ItW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 04:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264624AbTE1ItW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 04:49:22 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:58634 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S264623AbTE1ItV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 04:49:21 -0400
To: steelgate <steelgate@alpha1.infor.org>
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: kernel 2.5.70 oops on alpha
References: <Pine.LNX.4.55.0305281656490.3009@alpha1.infor.org>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 28 May 2003 11:00:12 +0200
Message-ID: <wrphe7fla3n.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <Pine.LNX.4.55.0305281656490.3009@alpha1.infor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "steelgate" == steelgate  <steelgate@alpha1.infor.org> writes:

steelgate> When booting kernel 2.5.70, I've got following messages:

See the patch Ivan posted yesterday to LKML, which seems to solve this
problem.

        M.
-- 
Places change, faces change. Life is so very strange.
