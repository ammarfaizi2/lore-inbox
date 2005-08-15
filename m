Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbVHOLV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbVHOLV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 07:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbVHOLV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 07:21:28 -0400
Received: from mirapoint2.brutele.be ([212.68.199.149]:6946 "EHLO
	mirapoint2.brutele.be") by vger.kernel.org with ESMTP
	id S932671AbVHOLV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 07:21:27 -0400
Date: Mon, 15 Aug 2005 13:21:22 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Stephane Wirtel <stephane.wirtel@belgacom.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [USB-Storage : i386] Oops with an adaptor for laptop hard disk.
Message-ID: <20050815112122.GB6451@localhost.localdomain>
References: <20050815102925.GA843@localhost.localdomain> <20050815110836.GA16201@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050815110836.GA16201@mipter.zuzino.mipt.ru>
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.9i
X-Junkmail-Status: score=10/50, host=mirapoint2.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090205.43007849.000E-F-L0BeBC04zsV01UPbcJcIKw==,  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?p=3D=C0=F5=08=08?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Monday 15 August 2005 a 15:08, Alexey Dobriyan ecrivait: 
> On Mon, Aug 15, 2005 at 12:29:25PM +0200, Stephane Wirtel wrote:
> > With a laptop hard disk adaptop to usb, I do a modprobe with the
> > usb-storage module. If I disconnect my hard disk, I get an oops.
> 
> > nvidia 3711688 14 - Live 0xe10f1000
> 
> > EIP:    0060:[<c019710b>]    Tainted: P      VLI
> 
> Is it reproducable without nvidia module loaded?
Yes :( 

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>

