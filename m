Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKKBgN>; Fri, 10 Nov 2000 20:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129551AbQKKBgD>; Fri, 10 Nov 2000 20:36:03 -0500
Received: from u-172.karlsruhe.ipdial.viaginterkom.de ([62.180.19.172]:37893
	"EHLO u-172.karlsruhe.ipdial.viaginterkom.de") by vger.kernel.org
	with ESMTP id <S129103AbQKKBfp>; Fri, 10 Nov 2000 20:35:45 -0500
Date: Sat, 11 Nov 2000 02:35:21 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Message-ID: <20001111023521.D29352@bacchus.dhis.org>
In-Reply-To: <3A0C3F30.F5EB076E@timpanogas.org> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <26054.973893835@euclid.cs.niu.edu> <8uhs7c$2hr$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <8uhs7c$2hr$1@cesium.transmeta.com>; from hpa@zytor.com on Fri, Nov 10, 2000 at 02:18:20PM -0800
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 02:18:20PM -0800, H. Peter Anvin wrote:

> Numerically high load averages aren't inherently a bad thing.  There
> isn't anything bad about a system with a loadavg of 20 if it does what
> it should in the time you'd expect.  However, if your daemons start
> blocking because they assume this number means badness, than that is
> the problem, not the loadavg in itself.

The problem seems to me that the load figure doesn't express what most
people seem to expect it to - CPU load.

  Ralf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
