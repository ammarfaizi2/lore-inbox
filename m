Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbUCKOcR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUCKOcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:32:17 -0500
Received: from av5-2-sn1.fre.skanova.net ([81.228.11.112]:42477 "EHLO
	av5-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261388AbUCKObk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:31:40 -0500
Subject: Re: Strange DMA-errors and system hang with Promise 20268
From: Henrik Persson <nix@syndicalist.net>
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0403110327190.11871-100000@dirac.phys.uwm.edu>
References: <Pine.GSO.4.21.0403110327190.11871-100000@dirac.phys.uwm.edu>
Content-Type: text/plain
Message-Id: <1079015495.2088.0.camel@vega>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 15:31:36 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-11 at 10:36, Bruce Allen wrote:
*snip*

> FWIW, there have been reports of problems (system lockup) with
> smartmontools on systems with Promise 20262 and 20265 controllers. See:
> http://cvs.sourceforge.net/viewcvs.py/smartmontools/sm5/WARNINGS?sortby=date&view=markup
> So I guess I will need to add the 20268 controller to this list, although
> as Mario says, smartmontools may play only an indirect role, in exposing
> an existing problem.

Well. I guess it's an existing problem, cause I didn't even have
smartmontools installed until Mario brought it up. ;)

-- 
Henrik Persson <nix@syndicalist.net>

