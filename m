Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbTCGADt>; Thu, 6 Mar 2003 19:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261301AbTCGADt>; Thu, 6 Mar 2003 19:03:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60072
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261294AbTCGADs>; Thu, 6 Mar 2003 19:03:48 -0500
Subject: Re: UHCI breaks with io-apic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: fauxpas@temp123.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030307000726.GA6684@temp123.org>
References: <20030307000726.GA6684@temp123.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046999988.17715.150.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 01:19:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 00:07, fauxpas@temp123.org wrote:
> I have a Via KT266A motherboard with 2 integrated UHCI USB HCD's.
> On an SMP kernel or with IO-APIC on UP enabled, they fail in the
> following way:

IO-APIC on VIA requires a current 2.4.21pre-ac or 2.5.64-ac kernel.
Then it might work for the chipset devices like the USB.

