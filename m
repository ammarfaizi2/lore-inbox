Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbULFObp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbULFObp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 09:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbULFObp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 09:31:45 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:35768 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261537AbULFO3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 09:29:11 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: nVidea Graphics card not recognised by lspci
Date: Mon, 6 Dec 2004 14:29:05 +0000
User-Agent: KMail/1.7
Cc: Martin Zwickel <martin.zwickel@technotrend.de>,
       "Riley Williams" <riley_howard_williams@hotmail.com>
References: <kiiZIHd0T0000153f@hotmail.com> <BAY101-F22378AB0D9016021445311ABB40@phx.gbl> <20041206121608.585d7526@phoebee>
In-Reply-To: <20041206121608.585d7526@phoebee>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412061429.05910.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 Dec 2004 11:16, Martin Zwickel wrote:
> On Mon, 06 Dec 2004 10:44:16 +0000
>
> "Riley Williams" <riley_howard_williams@hotmail.com> bubbled:
> > Hi all.
> >
> > The enclosed is the output from `lspci -vvv` for the video card on one
> > of my systems. Can anybody tell me any more about this card, as
> > "Unknown device 0322" isn't too useful a description.
>
> Your lspci database is too old.
>
> Your card should be (taken from pci.ids):
>     0322  NV34 [GeForce FX 5200]
>

Incase you don't know, just run update-pciids to download/install the latest 
ids, then try lspci again

Andrew
