Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbTIONsO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 09:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbTIONsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 09:48:14 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:60834 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261354AbTIONrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 09:47:47 -0400
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: piggin@cyberone.com.au, davidsen@tmr.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zwane@linuxpower.ca
In-Reply-To: <200309151054.h8FAsepr001086@81-2-122-30.bradfords.org.uk>
References: <200309151054.h8FAsepr001086@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063633514.3734.17.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Mon, 15 Sep 2003 14:45:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-15 at 11:54, John Bradford wrote:
> In the model I'm proposing, the 386 kernel would be missing the Athlon
> workarounds.

This is unworkable unless you also have all the existing models where
you have fixes for later processors too. 
