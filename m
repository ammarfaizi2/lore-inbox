Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTLOIZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 03:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTLOIZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 03:25:41 -0500
Received: from [62.12.131.37] ([62.12.131.37]:25520 "HELO debian")
	by vger.kernel.org with SMTP id S263387AbTLOIZj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 03:25:39 -0500
Date: Mon, 15 Dec 2003 09:25:37 +0100
From: "Zeno R.R. Davatz" <zdavatz@ywesee.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alsa on gentoo ppc 2.6.0-test11-benh1
Message-Id: <20031215092537.165b6954.zdavatz@ywesee.com>
In-Reply-To: <1071475558.12501.413.camel@gaston>
References: <20031212083609.6db56e5b.zdavatz@ywesee.com>
	<1071474131.12496.411.camel@gaston>
	<20031215090427.7071fc29.zdavatz@ywesee.com>
	<1071475558.12501.413.camel@gaston>
Organization: ywesee - intellectual capital connected
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 19:05:58 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2003-12-15 at 19:04, Zeno R.R. Davatz wrote:
> > On Mon, 15 Dec 2003 18:42:12 +1100
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > 
> > > It seems you are trying to load both dmasound_pmac and alsa
> > > snd-powermac, they are mutually exclusive.
> 
> Check what's up if you don't have previously loaded dmasound_pmac
Ok, I just done emerge -U for 2.6.0_beta11-r2

Lets see how that goes.

Another issue I could remember was when I tried to make the modules for the hcfusbmodem. During /usr/sbin/hcfusbconfig I got an error that told me that modversion.h is missing.

TIA
Zeno

-- 
Mit freundlichen Grüssen / best regards

Zeno Davatz
Verkauf & Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.oddb.org
