Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264742AbTFLFk0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 01:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264744AbTFLFk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 01:40:26 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:48276 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264742AbTFLFkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 01:40:25 -0400
Date: Thu, 12 Jun 2003 06:53:56 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Toplica Tanaskovi?? <toptan@sezampro.yu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via KT400 and AGP 8x Support
Message-ID: <20030612055356.GA21193@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Toplica Tanaskovi?? <toptan@sezampro.yu>,
	linux-kernel@vger.kernel.org
References: <20030611212654.61150.qmail@web11307.mail.yahoo.com> <200306120036.21691.toptan@sezampro.yu> <20030611225350.GA522@suse.de> <200306120244.45476.toptan@sezampro.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306120244.45476.toptan@sezampro.yu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 02:44:45AM +0200, Toplica Tanaskovi?? wrote:
 > Dana ??etvrtak 12. jun 2003. 00:53, Dave Jones je napisao/la:
 > > That's likely an X limitation. Someone with X-fu needs to hack that up
 > > so it passes the right things through to agpgart. Would be nice to have
 > > that in place for the next X release, so that when distros come to start
 > > shipping 2.6, userspace is up to speed.
 > 
 > 	It's going to be difficult one, because, there are no hw. acc. drivers for 
 > nVidia built in X, and there is no R300 accel. Don't know about nv, but for 
 > Radeon chips only R300 can engage 8x transfer, so until ATI releases docs, or 
 > some genius figures how R300 work in 3D, IMHO there is no point of hacking X.

The 9200 is an R200 core (actually RV280) with AGP x8 support.

		Dave

