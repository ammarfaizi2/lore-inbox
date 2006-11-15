Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932823AbWKOHYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbWKOHYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932829AbWKOHYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:24:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:33968 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932828AbWKOHYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:24:51 -0500
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: David Miller <davem@davemloft.net>, torvalds@osdl.org, jeff@garzik.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
In-Reply-To: <adahcx1z6b8.fsf@cisco.com>
References: <Pine.LNX.4.64.0611141747490.3349@woody.osdl.org>
	 <455A7E21.7020701@garzik.org>
	 <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	 <20061114.190036.30187059.davem@davemloft.net>
	 <1163563260.5940.205.camel@localhost.localdomain>
	 <adahcx1z6b8.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 18:24:15 +1100
Message-Id: <1163575455.5940.224.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> which is not to say that there are no chipsets with errata in this
> area.  But I've never heard of such a thing...

Ok. Well, I've seen my load of PCI host bridges that were designed with
the PCI spec as toilet paper...

Ben.


