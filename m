Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267994AbUH2O7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUH2O7v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 10:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbUH2O7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 10:59:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:60902 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267994AbUH2O73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 10:59:29 -0400
Message-ID: <4131EF4D.5080400@suse.de>
Date: Sun, 29 Aug 2004 16:59:25 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Rigtorp <erik@rigtorp.com>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] make swsusp produce nicer screen output
References: <20040820152317.GA7118@linux.nu> <20040823174217.GC603@openzaurus.ucw.cz> <20040823200858.GA4593@linux.nu> <20040824214929.GA490@openzaurus.ucw.cz> <20040829135403.GA8182@linux.nu>
In-Reply-To: <20040829135403.GA8182@linux.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Rigtorp wrote:
> On Tue, Aug 24, 2004 at 11:49:30PM +0200, Pavel Machek wrote:

>>It really should not crash. 100 pages is 4MB. Thats little low but
>>seems possible.
> 
> Well it's probably best to handle this case, to be on the safe side.

yes, better safe than sorry. And it's not exactly a hot code path.

> Here's a new version of the patch.

i like it,  FWIW :-)

Regards,

   Stefan
