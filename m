Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbTFFPQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTFFPQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:16:47 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48529
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261888AbTFFPQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:16:46 -0400
Subject: Re: PCI cache line messages 2.4/2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@pobox.com, margitsw@t-online.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030605.221108.78711828.davem@redhat.com>
References: <1054812011.15276.37.camel@dhcp22.swansea.linux.org.uk>
	 <20030605.042536.41633837.davem@redhat.com>
	 <1054842521.15275.45.camel@dhcp22.swansea.linux.org.uk>
	 <20030605.221108.78711828.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054913267.17190.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jun 2003 16:27:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-06 at 06:11, David S. Miller wrote:
> First, can I get some english without the welsh grammar? :-)
> Second, BIOS callbacks are exactly what I see the compaq hotplug
> PCI driver doing.

The compaq driver isnt loaded at this point. There is a window of
opportunity

