Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274434AbRJTUvF>; Sat, 20 Oct 2001 16:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274505AbRJTUu4>; Sat, 20 Oct 2001 16:50:56 -0400
Received: from dsl027-178-158.sfo1.dsl.speakeasy.net ([216.27.178.158]:1408
	"HELO whiskey.synfin.net") by vger.kernel.org with SMTP
	id <S274434AbRJTUui>; Sat, 20 Oct 2001 16:50:38 -0400
Date: Sat, 20 Oct 2001 13:49:19 -0700 (PDT)
From: <justme@pobox.com>
X-X-Sender: <aturner@whiskey.synfin.net>
To: Greg KH <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13pre5 breaks usb-storage ?
In-Reply-To: <20011020125945.B4314@kroah.com>
Message-ID: <Pine.LNX.4.33.0110201348080.1498-100000@whiskey.synfin.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 20 Oct 2001, Greg KH wrote:

> If you use usb-uhci.o instead of uhci.o on 2.4.13-pre5, does that work?
> 
> The uhci.o driver has changed between -pre3 and -pre5, not usb-storage.

Yep, that works for me.

-- 
Aaron

