Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261717AbSJZXUu>; Sat, 26 Oct 2002 19:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261740AbSJZXUt>; Sat, 26 Oct 2002 19:20:49 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:6348 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261717AbSJZXUt>; Sat, 26 Oct 2002 19:20:49 -0400
Subject: Re: PATCH: Support PCI device sorting (Re: PCI device order problem)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "H. J. Lu" <hjl@lucon.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DBB1E29.5020402@pobox.com>
References: <1035540031.13032.3.camel@irongate.swansea.linux.org.uk>
	<20021025091102.A15082@lucon.org> <20021025202600.A3293@lucon.org>
	<3DBB0553.5070805@pobox.com> <20021026142704.A13207@lucon.org>
	<3DBB0A81.6060909@pobox.com> <20021026144441.A13479@lucon.org>
	<3DBB1150.2030800@pobox.com> <20021026152043.A13850@lucon.org>
	<3DBB1743.6060309@pobox.com> <20021026155342.A14378@lucon.org> 
	<3DBB1E29.5020402@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Oct 2002 00:45:00 +0100
Message-Id: <1035675900.12995.136.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-26 at 23:58, Jeff Garzik wrote:
> In my first reply, I clearly separated implementation issues from 
> commentary on the overall idea.  Aside from that, I don't see much value 
> in further repeating what I've already said.

Its pretty pointless code but since its done at boot time, just marking
it __init ought to be quite sufficient.

