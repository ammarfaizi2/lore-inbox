Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271928AbTHDQsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271929AbTHDQsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:48:23 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:43164 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271928AbTHDQsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:48:22 -0400
Subject: Re: CDrecord -> Kernel panic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: autobot@bol.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308041504.h74F4n5o013600@burner.fokus.fraunhofer.de>
References: <200308041504.h74F4n5o013600@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060015391.719.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Aug 2003 17:43:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-08-04 at 16:04, Joerg Schilling wrote:
> Recent 2.4 (>= 2.4.18) Kernels seem to be a nightmare with IDE drivers.
> Maybe one of the kernel hackers has an idea. 

2.4.21 fixed the reset v scsi retry race problem. (Also current Red Hat
errata)


