Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbTABQWW>; Thu, 2 Jan 2003 11:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbTABQWW>; Thu, 2 Jan 2003 11:22:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55943
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262692AbTABQWU>; Thu, 2 Jan 2003 11:22:20 -0500
Subject: Re: 2.5.x Configuration - about ISA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301021404490.26251-100000@dns.toxicfilms.tv>
References: <Pine.LNX.4.44.0301021404490.26251-100000@dns.toxicfilms.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Jan 2003 17:13:34 +0000
Message-Id: <1041527614.24809.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-02 at 13:06, Maciej Soltysiak wrote:
> Hi,
> 
> When CONFIG_ISA is disabled and CONFIG_PNP_CARD is enabled, an option
> appears:
> CONFIG_ISAPNP
> 
> If we disabled ISA bus, shold not ISA Plug and Play be disabled too ?

ISAPnP yes, PNPBIos no

