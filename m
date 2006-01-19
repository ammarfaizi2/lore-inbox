Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161462AbWASWoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161462AbWASWoH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161466AbWASWoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:44:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52459 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161462AbWASWoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:44:05 -0500
Date: Thu, 19 Jan 2006 17:42:22 -0500
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060119224222.GW21663@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lee Revell <rlrevell@joe-job.com>, Krzysztof Halasa <khc@pm.waw.pl>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, perex@suse.cz
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe> <1137709135.8471.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137709135.8471.73.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 10:18:55PM +0000, Alan Cox wrote:
 > On Iau, 2006-01-19 at 15:43 -0500, Lee Revell wrote:
 > > Even the NeoMagic 256 which is a Pentium II era device and was in
 > > widespread use we cannot find a tester for.
 > 
 > There are plenty of neomagic audio users around, I've seen bug reports
 > about neomagic + ALSA hangs that have been filed.

They should be pretty easy to track down. Search for bug reports
with "Dell Latitude hangs" :-)

Here's three from Fedora bugzilla to start with..
http://tinyurl.com/dcy3e

(The bug is long-since fixed, but the reporters may still have the
 hardware and be willing to provide feedback to ALSA developers)

		Dave

