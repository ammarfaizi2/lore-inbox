Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWE3QVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWE3QVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWE3QVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:21:13 -0400
Received: from isilmar.linta.de ([213.239.214.66]:12757 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751562AbWE3QVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:21:13 -0400
Date: Mon, 29 May 2006 17:17:56 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH 6/14/] Doc. sources: expose pcmcia/
Message-ID: <20060529151756.GC11113@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <20060521203349.40b40930.rdunlap@xenotime.net> <20060521205742.0cd2273b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521205742.0cd2273b.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 21, 2006 at 08:57:42PM -0700, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Documentation/pcmcia/:
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

Applied, thanks.

	Dominik
