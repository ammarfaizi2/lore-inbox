Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754578AbWKHMnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578AbWKHMnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754582AbWKHMnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:43:16 -0500
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:7103 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1754578AbWKHMnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:43:15 -0500
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: VIA IRQ quirk missing PCI ids since 2.6.16.17
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Wilco Beekhuizen <wilcobeekhuizen@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <6c4c86470611080054r21f5c632u674da23bf3d1cc32@mail.gmail.com>
References: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com>
	 <1162817254.5460.4.camel@localhost.localdomain>
	 <1162847625.10086.36.camel@localhost.localdomain>
	 <20061107012519.GC25719@redhat.com>
	 <1162863274.11073.41.camel@localhost.localdomain>
	 <6c4c86470611080054r21f5c632u674da23bf3d1cc32@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 12:43:12 +0000
Message-Id: <1162989792.2693.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully in 2.6.19, we will get the patch that I mention in this
thread , Had you test it ? 
 
On Wed, 2006-11-08 at 09:54 +0100, Wilco Beekhuizen wrote:
> Why was this changed in the stable kernel anyway, especially in a
> micro-stability update? It seems to me it breaks more than it fixes.

