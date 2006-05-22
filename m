Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWEVUFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWEVUFn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 16:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWEVUFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 16:05:43 -0400
Received: from outmx023.isp.belgacom.be ([195.238.4.204]:49369 "EHLO
	outmx023.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750802AbWEVUFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 16:05:42 -0400
Date: Mon, 22 May 2006 22:05:29 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH 1/14/] Doc. sources: expose watchdog
Message-ID: <20060522200529.GB4175@infomag.infomag.iguana.be>
References: <20060521205810.64b631e2.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521205810.64b631e2.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

> Documentation/watchdog/:
> Expose example and tool source files in the Documentation/ directory in
> their own files instead of being buried (almost hidden) in readme/txt files.
> 
> This will make them more visible/usable to users who may need
> to use them, to developers who may need to test with them, and
> to janitors who would update them if they were more visible.
> 
> Also, if any of these possibly should not be in the kernel tree at
> all, it will be clearer that they are here and we can discuss if
> they should be removed.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

Has been added to the linux-2.6-watchdog-mm git tree.

Greetings,
Wim.

