Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVBXFVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVBXFVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 00:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVBXFVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 00:21:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1166 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261798AbVBXFVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 00:21:35 -0500
Message-ID: <421D6442.3030308@pobox.com>
Date: Thu, 24 Feb 2005 00:21:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <mlord@pobox.com>
CC: Alexey Dobriyan <adobriyan@mail.ru>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11+ sata_qstor] libata: sata_qstor cosmetic fixes
References: <421CE018.5030007@pobox.com> <200502232345.23666.adobriyan@mail.ru> <421D1113.9030502@pobox.com>
In-Reply-To: <421D1113.9030502@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Minor patch for new 2.6.xx sata_qstor driver attached,
> as per Alexey's fine-toothed comb!  :)
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

I had to apply this manually, since your mailer "corrupts" the patch by 
encoding text/plain as base64.  Please fix your mailer...

The ideal is an inline patch, rather than an attachment anyway.  e.g.

To: ...
From: ...
Subject: ...
<blank line>
Patch description
Patch

cat'd to 'sendmail -t'.  Sendmail (or another MTA which provides a 
/usr/sbin/sendmail wrapper) will automatically fill in other headers 
like Message-ID and Date.

	Jeff



