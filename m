Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbTIHOcf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbTIHOcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:32:35 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:59522 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262208AbTIHOcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:32:33 -0400
Subject: Re: kernel header separation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <willy@debian.org>,
       Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030908142545.GA3926@gtf.org>
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk>
	 <20030903014908.GB1601@codepoet.org>
	 <20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk>
	 <20030905211604.GB16993@codepoet.org>
	 <20030905232212.GP18654@parcelfarce.linux.theplanet.co.uk>
	 <1063028303.32473.333.camel@hades.cambridge.redhat.com>
	 <1063030329.21310.32.camel@dhcp23.swansea.linux.org.uk>
	 <20030908142545.GA3926@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063031476.21084.46.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Mon, 08 Sep 2003 15:31:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-08 at 15:25, Jeff Garzik wrote:
> Well, strictly speaking, __u8 is an internal gcc not kernel type.

At the end of this round you score zero points.

__u8 is just a typedef. No magic.

