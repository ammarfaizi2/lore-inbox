Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbTFEThp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 15:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbTFETho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 15:37:44 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26508
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264928AbTFETho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 15:37:44 -0400
Subject: Re: PCI cache line messages 2.4/2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@pobox.com, margitsw@t-online.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030605.042536.41633837.davem@redhat.com>
References: <1054809554.15276.8.camel@dhcp22.swansea.linux.org.uk>
	 <1054811157.19407.3.camel@rth.ninka.net>
	 <1054812011.15276.37.camel@dhcp22.swansea.linux.org.uk>
	 <20030605.042536.41633837.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054842521.15275.45.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jun 2003 20:48:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-06-05 at 12:25, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 05 Jun 2003 12:20:12 +0100
>    
>    And then there is hotplug
>    
> My understanding is that the bioses do the cacheline, irq,
> etc. assignment via BIOS callbacks done by the PCI controller hotplug
> driver.

Ah cloud cuckoo land 8)

Come on down Dave ;)

