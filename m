Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271872AbTGRWLU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271855AbTGRWKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:10:47 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62423
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271869AbTGRWIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:08:21 -0400
Subject: Re: [PATCH] 2.6.0-test1-after-alan-s-patch - More Makefile/Kconfig
	bits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20030719001256.C780@electric-eye.fr.zoreil.com>
References: <200307181432.h6IEW9Mt017886@hraefn.swansea.linux.org.uk>
	 <20030719001256.C780@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058566841.19558.101.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jul 2003 23:20:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-18 at 23:12, Francois Romieu wrote:
> Adds kahlua, harmony and hal2 drivers amongst the build options.
> 

I left the harmony and hal2 out intentionally because they are tied to
MIPS and PARISC build rules that are not yet really finalised for 2.6,
but this looks fine

