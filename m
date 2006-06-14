Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWFNQoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWFNQoZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 12:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWFNQoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 12:44:24 -0400
Received: from [80.71.248.82] ([80.71.248.82]:21404 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1750831AbWFNQoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 12:44:23 -0400
X-Comment-To: grundig
To: grundig <grundig@teleline.es>
Cc: Alex Tomas <alex@clusterfs.com>, jeff@garzik.org, alan@lxorguk.ukuu.org.uk,
       chase.venters@clientec.com, adilger@clusterfs.com, akpm@osdl.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	<20060609181020.GB5964@schatzie.adilger.int>
	<Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
	<m31wty9o77.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>
	<1149880865.22124.70.camel@localhost.localdomain>
	<m3irna6sja.fsf@bzzz.home.net> <4489CB42.6020709@garzik.org>
	<m3wtbq5dgw.fsf@bzzz.home.net>
	<20060611221438.cecef685.grundig@teleline.es>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
In-Reply-To: <20060611221438.cecef685.grundig@teleline.es> (grundig@teleline.es's message of "Sun, 11 Jun 2006 22:14:46 +0200 (added by postmaster@terra.es)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Date: Wed, 14 Jun 2006 20:45:50 +0400
Message-ID: <m3k67j4rep.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> grundig  (g) writes:

 g> Distros may ignore your opinion and may enable it, and users won't know
 g> that it's enabled or even if such feature exist - until they try to run
 g> an older kernel. If almost nobody needs this feature, why not avoid
 g> problems by not merging it and maintaining it separated from the
 g> main tree?

not sure, in such a distro such an user will be aware he's using ext4.
about "nobody needs ...": see my question regarding NUMA in kernel.

thanks, Alex
