Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTADT4L>; Sat, 4 Jan 2003 14:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbTADT4L>; Sat, 4 Jan 2003 14:56:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63872
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261353AbTADT4K>; Sat, 4 Jan 2003 14:56:10 -0500
Subject: Re: [PATCH] Make ide-probe more robust to non-ready devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1041672876.1346.23.camel@zion.wanadoo.fr>
References: <1041672876.1346.23.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041713307.2036.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 04 Jan 2003 20:48:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-04 at 09:34, Benjamin Herrenschmidt wrote:
> I don't expect this patch to break any existing working configuration,
> so please send to Linus for 2.5. If you accept it, I'll then send a 2.4
> version to Marcelo as well. This have been around for some time and,
> imho, should really get in now.

There is a ton of stuff pending for 2.5 IDE. Unfortunately 2.5 isn't in
a state I can do any usable testing so it will have to wait. The Marcelo
2.4 tree is current and I'm doing the work in 2.4 first now.

Rusty seems to have a lot of the module stuff in hand so hopefully I'll
get back onto 2.5 after LCA


Alan

