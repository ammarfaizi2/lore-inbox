Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSKKWGf>; Mon, 11 Nov 2002 17:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbSKKWGf>; Mon, 11 Nov 2002 17:06:35 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:28837 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261529AbSKKWGe>; Mon, 11 Nov 2002 17:06:34 -0500
Subject: Re: Promise Ultra100 TX2 driver problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: adamm@galacticasoftware.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021111192648.GA31966@galacticasoftware.com>
References: <20021111192648.GA31966@galacticasoftware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Nov 2002 22:38:08 +0000
Message-Id: <1037054288.2887.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 19:26, adamm@galacticasoftware.com wrote:
> Hi all,
> 
> There seems to be a major problem with the promise drivers.
> It is detected and seems to work, but there is a very 
> large number of interrupts being generated:

Im dubious those interrupts are coming from the TX2 - what happens if
you boot with the "noapic" option ?

