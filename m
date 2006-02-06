Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWBFDnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWBFDnX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 22:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWBFDnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 22:43:23 -0500
Received: from birao.terra.com.br ([200.176.10.197]:906 "EHLO
	birao.terra.com.br") by vger.kernel.org with ESMTP id S1750936AbWBFDnW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 22:43:22 -0500
X-Terra-Karma: -2%
X-Terra-Hash: 007c251ce383497503d9552675793443
Message-ID: <43E6C559.9040907@terra.com.br>
Date: Mon, 06 Feb 2006 01:41:13 -0200
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051004
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Richard Purdie <rpurdie@rpsys.net>, jbowler@acm.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [PATCH 8/12] LED: Add LED device support for ixp4xx devices]
References: <1139154997.14624.20.camel@localhost.localdomain> <20060205192025.4006a554.akpm@osdl.org>
In-Reply-To: <20060205192025.4006a554.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi,

Andrew Morton wrote:

> MIT license is unusual. There's one other file in the kernel which uses it
>
>and that's down in MTD where nobody dares look.
>
>I don't know whether MIT is GPL-compatible-for-kernel-purposes or not.  Help.
>

    Well, checking FSF's licenses page, there's an entry about a license
which *might* be the same as this:

"X11 License

This is a simple, permissive non-copyleft free software license,
compatible with the GNU GPL.
...
This license is sometimes called the "MIT" license, but that term is
misleading, since MIT has used many licenses for software."

<http://www.fsf.org/licensing/licenses/index_html/view?searchterm=software%20licenses>

    So my unreliable opinion is yes: This is
GPL-compatible-for-kernel-purposes.

    Cheers,

Felipe Damasio
