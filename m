Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbSLLUbW>; Thu, 12 Dec 2002 15:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267498AbSLLUbV>; Thu, 12 Dec 2002 15:31:21 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:49350
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267497AbSLLUbU>; Thu, 12 Dec 2002 15:31:20 -0500
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreani Stefano <stefano.andreani.ap@h3g.it>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <047ACC5B9A00D741927A4A32E7D01B73D66178@RMEXC01.h3g.it>
References: <047ACC5B9A00D741927A4A32E7D01B73D66178@RMEXC01.h3g.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Dec 2002 21:16:49 +0000
Message-Id: <1039727809.22174.38.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-12 at 20:18, Andreani Stefano wrote:
> Never say never ;-) 
> I need to change it now as a temporary workaround for a problem in the UMTS core network of my company. But I think there could be thousands of situations where a fine tuning of this TCP parameter could be useful.
>
The default is too short ?

