Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267682AbSLTByJ>; Thu, 19 Dec 2002 20:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267684AbSLTByJ>; Thu, 19 Dec 2002 20:54:09 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20460
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267682AbSLTByJ>; Thu, 19 Dec 2002 20:54:09 -0500
Subject: Re: 2.4.20: Broken AGP initialization for i845G chipset [patch]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Milligan <milli@acmeps.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E025858.4000404@acmeps.com>
References: <3E025858.4000404@acmeps.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Dec 2002 02:43:10 +0000
Message-Id: <1040352190.30798.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 23:38, Michael Milligan wrote:
> Chipset detection for the new Intel i845G chipset was added into the AGPGART
> driver, but it appears to call the wrong initialization routine.  Stock 
> compile

Ok I sent one of those to Marcelo for 2.4.21pre2. I'm not sure if I got
both

