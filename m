Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262977AbVHELDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbVHELDS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 07:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbVHELDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 07:03:17 -0400
Received: from [85.8.12.41] ([85.8.12.41]:47243 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262977AbVHELCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 07:02:44 -0400
Message-ID: <42F34734.50809@drzeus.cx>
Date: Fri, 05 Aug 2005 13:02:12 +0200
From: Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-0.1.fc5 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch] Fix a bit/byte counting error in the MMC/SD code
References: <1123191640.8987.68.camel@localhost.localdomain>
In-Reply-To: <1123191640.8987.68.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
> This fixes what looks like a bit/byte counting error in the MMC/SD code
> which was causing data corruption (in the -mm tree).
> 
> Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Ooops... Must have been late in the evening. Sorry about that blunder.

Rgds
Pierre
