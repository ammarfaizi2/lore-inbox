Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTLOIYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 03:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTLOIYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 03:24:09 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:34737 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263376AbTLOIYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 03:24:07 -0500
Subject: Re: alsa on gentoo ppc 2.6.0-test11-benh1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Zeno R.R. Davatz" <zdavatz@ywesee.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1071475558.12501.413.camel@gaston>
References: <20031212083609.6db56e5b.zdavatz@ywesee.com>
	 <1071474131.12496.411.camel@gaston>
	 <20031215090427.7071fc29.zdavatz@ywesee.com>
	 <1071475558.12501.413.camel@gaston>
Content-Type: text/plain
Message-Id: <1071476493.11009.415.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Dec 2003 19:21:33 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-15 at 19:05, Benjamin Herrenschmidt wrote:
> On Mon, 2003-12-15 at 19:04, Zeno R.R. Davatz wrote:
> > On Mon, 15 Dec 2003 18:42:12 +1100
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > 
> > > It seems you are trying to load both dmasound_pmac and alsa
> > > snd-powermac, they are mutually exclusive.
> 
> Check what's up if you don't have previously loaded dmasound_pmac

I meant, make sure (/proc/modules) it is not as it was in your
original report

Ben


