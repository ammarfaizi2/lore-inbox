Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267737AbSLGJv2>; Sat, 7 Dec 2002 04:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbSLGJv2>; Sat, 7 Dec 2002 04:51:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59404 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267737AbSLGJv1>;
	Sat, 7 Dec 2002 04:51:27 -0500
Message-ID: <3DF1C643.5070900@pobox.com>
Date: Sat, 07 Dec 2002 04:58:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: acpi-devel@sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Proposed ACPI Licensing change
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A57F@orsmsx119.jf.intel.com>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A57F@orsmsx119.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:
> In order to solve this, we are considering releasing the Linux version of
> the interpreter under a dual license. This would allow direct incorporation
> of changes. Any patches submitted against the ACPI core code would
> implicitly be allowed to be used by us in a non-GPL context. This is already
> done elsewhere in the Linux kernel source by the PCMCIA code, for example.


I think this is great.

Since pcmcia already set an example with their license, I think it's a 
great model to follow.

I also echo other comments to choose an already-known license like the 
MPL or BSD (etc.) so that lawyers don't have extra work ;-)

	Jeff



