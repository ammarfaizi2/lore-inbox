Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267132AbTAFTiI>; Mon, 6 Jan 2003 14:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267133AbTAFTiI>; Mon, 6 Jan 2003 14:38:08 -0500
Received: from palrel10.hp.com ([156.153.255.245]:46221 "HELO palrel10.hp.com")
	by vger.kernel.org with SMTP id <S267132AbTAFTiH>;
	Mon, 6 Jan 2003 14:38:07 -0500
Date: Mon, 6 Jan 2003 11:45:13 -0800
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030106194513.GC26790@cup.hp.com>
References: <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com> <1041848998.666.4.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041848998.666.4.camel@zion.wanadoo.fr>
User-Agent: Mutt/1.4i
From: grundler@cup.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 11:31:10AM +0100, Benjamin Herrenschmidt wrote:
> For example, since we do not quite deal with PCI domains yet,

I thought Bjorn Helgaas submitted "PCI Segment" support for ia64?
Was something else missing from that? Or was that 2.4.x only?

IIRC, lspci needs to be fixed to support this as well.

grant
