Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbTIVNyV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 09:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTIVNyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 09:54:20 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:28807 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S263155AbTIVNyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 09:54:19 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Subject: Re: 2.6.0-test5-mm4
Date: Mon, 22 Sep 2003 14:54:16 +0100
User-Agent: KMail/1.5.9
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
References: <20030922013548.6e5a5dcf.akpm@osdl.org> <20030922143605.GA9961@gemtek.lt> <200309221449.37677.alistair@devzero.co.uk>
In-Reply-To: <200309221449.37677.alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309221454.16116.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 September 2003 14:49, Alistair J Strachan wrote:
[snip]
>
> I'll try that, thanks. But I have this in lilo.conf:
>
> boot=/dev/discs/disc0/disc
> root=/dev/discs/disc0/part2
>
> /dev/discs is indeed a symlink, but it should be resolved when LILO is
> installed, i.e., prior to the reboot. Why has this behaviour changed?
>

Changing it as per your suggestion makes no difference. I still cannot boot, 
and the error is identical.

Disregard my last email.

Cheers,
Alistair.
