Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTKLHiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 02:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTKLHiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 02:38:15 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:42978 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S261841AbTKLHiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 02:38:15 -0500
To: rob@landley.net
Cc: mzyngier@freesurf.fr, linux-kernel@vger.kernel.org
Subject: Re: Why can't I shut scsi device support off in -test9?
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <200311120046.04348.rob@landley.net>
	<wrpr80e84fm.fsf@hina.wild-wind.fr.eu.org>
	<200311120126.59472.rob@landley.net>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Wed, 12 Nov 2003 08:34:23 +0100
Message-ID: <wrpekwe82gw.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <200311120126.59472.rob@landley.net> (Rob Landley's message of
 "Wed, 12 Nov 2003 01:26:59 -0600")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rob" == Rob Landley <rob@landley.net> writes:

Rob> I tried switching SCSI support off by hand (editing .config) and
Rob> it still showed up in the menu.  (Maybe turned back on by a
Rob> dependency, but on what?)

Care to submit this .config ?

	M.
-- 
Places change, faces change. Life is so very strange.
