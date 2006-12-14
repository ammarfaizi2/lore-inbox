Return-Path: <linux-kernel-owner+w=401wt.eu-S1751692AbWLNIOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbWLNIOY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWLNIOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:14:24 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:24140
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751692AbWLNIOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:14:23 -0500
X-Greylist: delayed 1218 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 03:14:21 EST
Message-Id: <45811163.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 14 Dec 2006 07:54:59 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "dean gaudet" <dean@arctic.org>, "Chris Wright" <chrisw@sous-sol.org>
Cc: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Michael Buesch" <mb@bu3sch.de>,
       "Metathronius Galabant" <m.galabant@googlemail.com>,
       <stable@kernel.org>, "Michael Krufky" <mkrufky@linuxtv.org>,
       "Justin Forbes" <jmforbes@linuxtx.org>, <alan@lxorguk.ukuu.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>,
       "Chris Wedgwood" <reviews@ml.cw.f00f.org>, <akpm@osdl.org>,
       <torvalds@osdl.org>, "Chuck Wolber" <chuckw@quantumlinux.com>,
       "Dave Jones" <davej@redhat.com>, "Greg Kroah-Hartman" <gregkh@suse.de>,
       <linux-kernel@vger.kernel.org>, "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [stable] [PATCH 46/61] fix Intel RNG detection
References: <20061101053340.305569000@sous-sol.org>
 <20061101054343.623157000@sous-sol.org>
 <20061120234535.GD17736@redhat.com>
 <20061121022109.GF1397@sequoia.sous-sol.org>
 <4562D5DA.76E4.0078.0@novell.com>
 <20061122015046.GI1397@sequoia.sous-sol.org>
 <45640FF4.76E4.0078.0@novell.com> <20061124202729.GC29264@redhat.com>
 <456D56E7.76E4.0078.0@novell.com>
 <Pine.LNX.4.64.0612131145460.14936@twinlark.arctic.org>
 <20061213203325.GL10475@sequoia.sous-sol.org>
 <Pine.LNX.4.64.0612131458510.16018@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.64.0612131458510.16018@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>with the patch it boots perfectly without any command-line args.

Are you getting the 'Firmware space is locked read-only' message then?

Thanks, Jan
