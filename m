Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965296AbVKHTbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965296AbVKHTbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbVKHTba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:31:30 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:16862 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965285AbVKHTba convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:31:30 -0500
Subject: Re: Highpoint IDE types
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <pan.2005.11.08.19.02.09.190896@sci.fi>
References: <1131471483.25192.76.camel@localhost.localdomain>
	 <pan.2005.11.08.19.02.09.190896@sci.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Tue, 08 Nov 2005 20:02:20 +0000
Message-Id: <1131480140.25192.98.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-08 at 21:02 +0200, Ville Syrjälä wrote:
> >  *      HPT372                  4 (HPT366)      5     
> >  *      HPT372N                 4 (HPT366)      6     
> >  *      HPT372                  5 (HPT372)      0
>           ^^^^^^
> 
> This one is called HPT372A by Highpoint's BIOS/Win drivers.
> 
> Also I'm not sure if it's relevant but PCI ID 5 chips use a different
> BIOS image than PCI ID 4 chips.

I suspect it is relevant because the "372A" appears to have a different
base clock to the HPT372.

Added to the list.

