Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270313AbTGSOtZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 10:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270364AbTGSOtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 10:49:25 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:32010 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270313AbTGSOtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 10:49:22 -0400
Date: Sat, 19 Jul 2003 16:04:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: John Bradford <john@grabjohn.com>
Cc: lkml@lrsehosting.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, lm@bitmover.com, rms@gnu.org,
       Valdis.Kletnieks@vt.edu
Subject: Re: [OT] HURD vs Linux/HURD
Message-ID: <20030719160417.A5326@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	John Bradford <john@grabjohn.com>, lkml@lrsehosting.com,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
	lm@bitmover.com, rms@gnu.org, Valdis.Kletnieks@vt.edu
References: <200307191503.h6JF3tac002376@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307191503.h6JF3tac002376@81-2-122-30.bradfords.org.uk>; from john@grabjohn.com on Sat, Jul 19, 2003 at 04:03:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 04:03:55PM +0100, John Bradford wrote:
> What HURD code comes from Linux?  GNU/Mach uses code from Linux, but
> not HURD as far as I know.

the networking code at least (aka pfinet)

