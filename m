Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbSKFN1P>; Wed, 6 Nov 2002 08:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbSKFN1O>; Wed, 6 Nov 2002 08:27:14 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:22680 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265058AbSKFN04>; Wed, 6 Nov 2002 08:26:56 -0500
Subject: Re: [Evms-announce] EVMS announcement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Kevin Corry <corryk@us.ibm.com>, evms-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021106001607.GJ27832@marowsky-bree.de>
References: <02110516191004.07074@boiler> 
	<20021106001607.GJ27832@marowsky-bree.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 13:55:57 +0000
Message-Id: <1036590957.9803.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 00:16, Lars Marowsky-Bree wrote:
> Now, an interesting question is whether the md modules etc will simply be
> continued to be used or whether they'll make use of the DM engine too? Can
> they be made "plugins" to DM or the EVMS framework? Or even, could EVMS (in
> theory) parse the meta-data from a legacy md device and just setup a DM
> mapping for it? That would appeal to me quite a bit. I really need to start
> reading up on it...

I'm certainly hoping to kill off ataraid/pdcraid/hptraid by using device
mapper and md

