Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423750AbWKFKVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423750AbWKFKVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423762AbWKFKVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:21:15 -0500
Received: from nz-out-0102.google.com ([64.233.162.207]:1441 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1423750AbWKFKVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:21:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=soPs9Midvzjv0NoELDjO3PzzWA8R5mKEl1qqcUL9Jj0ZfeD/aPxZNpO0muIy8M3clikgTAYXH6+0oA4f57jDHpDZ+JcrpepXm3+xxIHm9xgsun8KyY3v9eVOUDUiLphQnQ7WXoUY4ncuEbcgpyA4e1dripfZrLrFnRJRXftZS5k=
Message-ID: <f55850a70611060221y25528116pa1b73aa89008f906@mail.gmail.com>
Date: Mon, 6 Nov 2006 18:21:12 +0800
From: "Zhao Xiaoming" <xiaoming.nj@gmail.com>
To: linux-kernel@vger.kernel.org, "Linux Netdev List" <netdev@vger.kernel.org>
Subject: Re: ZONE_NORMAL memory exhausted by 4000 TCP sockets
In-Reply-To: <1162807984.3160.188.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com>
	 <1162807984.3160.188.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/11/6, Arjan van de Ven <arjan@infradead.org>:
> On Mon, 2006-11-06 at 14:07 +0800, Zhao Xiaoming wrote:
> > Dears,
> >     I'm running a linux box with kernel version 2.6.16. The hardware
> > has 2 Woodcrest Xeon CPUs (2 cores each) and 4G RAM. The NIC cards is
> > Intel 82571 on PCI-e bus.
>
> are you using a 32 bit or a 64 bit OS?
>
>
>
