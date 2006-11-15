Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030936AbWKOT2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030936AbWKOT2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030937AbWKOT2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:28:12 -0500
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:46732
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1030933AbWKOT2K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:28:10 -0500
From: Michael Buesch <mb@bu3sch.de>
To: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: ANNOUNCE: SFLC helps developers assess ar5k (enabling free Atheros HAL)
Date: Wed, 15 Nov 2006 20:26:25 +0100
User-Agent: KMail/1.9.5
References: <20061115031025.GH3451@tuxdriver.com> <200611151942.14596.mb@bu3sch.de> <20061115192054.GA10009@tuxdriver.com>
In-Reply-To: <20061115192054.GA10009@tuxdriver.com>
Cc: madwifi-devel@lists.sourceforge.net, lwn@lwn.net, mcgrof@gmail.com,
       david.kimdon@devicescape.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611152026.26095.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 20:21, John W. Linville wrote:
> On Wed, Nov 15, 2006 at 07:42:14PM +0100, Michael Buesch wrote:
> 
> > Now that it seems to be ok to use these openbsd sources, should I port
> > them to my driver framework?
> > I looked over the ar5k code and, well, I don't like it. ;)
> > I don't really like having a HAL. I'd rather prefer a "real" driver
> > without that HAL obfuscation.
> 
> I don't think anyone likes the HAL-based architecture.  I don't think
> we will accept a HAL-based driver into the upstream kernel.

Yeah, wanted to hear that. ;)

> The point is that the ar5k is now safe to be used as a reference and
> source of information (and code, as appropriate) without copyright FUD.
> Distilling that information into a proper Linux driver is work that
> remains to be done.

Yeah, ok. I'll look what I can do. First I'll have to read the code.
and understand it. DMA stuff seems to be really obfuscated though
dozens of callbacks, heh. :)

-- 
Greetings Michael.
