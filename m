Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbTFULyL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 07:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbTFULyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 07:54:11 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13511
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265152AbTFULyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 07:54:10 -0400
Subject: Re: [RESEND] Giant oopses and crash at boot with 2.4.21-ac
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Henrik Persson <nix@syndicalist.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200306162055.h5GKtgZq029517@sirius.nix.badanka.com>
References: <200306162055.h5GKtgZq029517@sirius.nix.badanka.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056197103.26098.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jun 2003 13:05:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-16 at 21:55, Henrik Persson wrote:
> Hi.
> 
> When trying to boot 2.4.21-ac1 (and 2.4.21-rc8-ac1 too, actually) the
> kernel starts oopsing for a few minutes with infinite loops of call traces
> and since it won't log anything to the disc at this point and the fact

Try with ACPI disabled as a first test

