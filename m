Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTKLIXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 03:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTKLIXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 03:23:40 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:51170 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S261786AbTKLIXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 03:23:40 -0500
To: rob@landley.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why can't I shut scsi device support off in -test9?
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <200311120046.04348.rob@landley.net>
	<200311120126.59472.rob@landley.net>
	<wrpekwe82gw.fsf@hina.wild-wind.fr.eu.org>
	<200311120203.51599.rob@landley.net>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Wed, 12 Nov 2003 09:19:49 +0100
Message-ID: <wrpu15a6lsq.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <200311120203.51599.rob@landley.net> (Rob Landley's message of
 "Wed, 12 Nov 2003 02:03:51 -0600")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Odd...

I simply put your .config in my test9-latest tree, removed
CONFIG_SCSI with 'make menuconfig', and it simply went away...

Maybe someone fixed this behaviour in test9-latest ?

	M.
-- 
Places change, faces change. Life is so very strange.
