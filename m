Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269646AbRISVtt>; Wed, 19 Sep 2001 17:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274199AbRISVtj>; Wed, 19 Sep 2001 17:49:39 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:60272 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S269646AbRISVt0>; Wed, 19 Sep 2001 17:49:26 -0400
Date: Wed, 19 Sep 2001 16:48:59 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Replace the eepro100 driver with the e100 driver??
In-Reply-To: <3BA90EF2.527C9A50@candelatech.com>
Message-ID: <Pine.LNX.3.96.1010919164534.4526A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Ben Greear wrote:
> The e100 license appears to be compatible, and it has some nice features, like

Old news, and it is definitely -not- compatible :/

Every Linux distributor (or other entity) that ships e100 -must-
get an specific exemption from Intel's lawyers, because the license
does not cover patent liability.

So as I understand it (IANAL), with an exemption, Intel can sue an
end user over patent issues.  The GPL would protect against such
business...

Also AFAIK, this is a problem with most if not all IP covered by patents
-and- a BSD license.

Again, IANAL, but this is what I was told from a trusted source, and
backed up by another...

	Jeff




