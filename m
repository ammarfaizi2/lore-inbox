Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbTE1Gh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 02:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbTE1Gh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 02:37:26 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:24801 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264553AbTE1Gh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 02:37:26 -0400
Date: Wed, 28 May 2003 07:52:13 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Roman Zippel <zippel@linux-m68k.org>, John Stoffel <stoffel@lucent.com>,
       DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <20030528065213.GB16807@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	John Stoffel <stoffel@lucent.com>,
	DevilKin-LKML <devilkin-lkml@blindguardian.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com> <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com> <200305271729.49047.devilkin-lkml@blindguardian.org> <20030527153619.GJ8978@holomorphy.com> <16083.35048.737099.575241@gargle.gargle.HOWL> <Pine.LNX.4.44.0305272010550.12110-100000@serv> <20030527184016.GA5847@suse.de> <4060000.1054072761@[10.10.2.4]> <20030528033459.GR8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528033459.GR8978@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 08:34:59PM -0700, William Lee Irwin III wrote:

 > Or better yet, remove all the #ifdefs, finish generalizing the APIC
 > code, and have nothing to configure at all. For 2.7 ...

Yes, even better. Especially for distros. Andi did some work in
this area, but there is still work to be done there.

		Dave
