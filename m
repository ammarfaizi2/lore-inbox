Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287237AbSANMYl>; Mon, 14 Jan 2002 07:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289219AbSANMYb>; Mon, 14 Jan 2002 07:24:31 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:48154 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289218AbSANMYN>; Mon, 14 Jan 2002 07:24:13 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200201141224.g0ECOBe28867@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.18pre3-ac2
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Mon, 14 Jan 2002 07:24:11 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3C42CD74.3020200@evision-ventures.com> from "Martin Dalecki" at Jan 14, 2002 01:22:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you include the i810_audio.c patches eas well please. Without them 
> the driver isn't quite usable at least on SiS735 based motherboards.

I'm sure Doug will send i810 audio to Marcelo. I'm not trying to duplicate
work here. Most of that diff is just because I went back over the patches
from the transitional period
