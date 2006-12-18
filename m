Return-Path: <linux-kernel-owner+w=401wt.eu-S1754553AbWLRVYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbWLRVYc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 16:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754591AbWLRVYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 16:24:32 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:1763 "EHLO
	mail1.webmaster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553AbWLRVYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 16:24:31 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPL only modules
Date: Mon, 18 Dec 2006 13:23:59 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEDMAHAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.64.0612181242530.3479@woody.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 18 Dec 2006 14:27:16 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 18 Dec 2006 14:27:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Static vs dynamic matters for whether it's an AGGREGATE work. Clearly,
> static linking aggregates the library with the other program in the same
> binary. There's no question about that. And that _does_ have meaning from
> a copyright law angle, since if you don't have permission to ship
> aggregate works under the license, then you can't ship said binary. It's
> just a non-issue in the specific case of the GPLv2.

The right to ship aggregate works is not one specifically reserved by law to
the copyright holder. It's also not clear that an aggregate work is in fact
a single work for any legal purpose other than the aggregator's claim to
copyright. All you need to ship an aggregated work is the right to ship each
of the individual works aggregated in it. For GPL'd works, you get that
right from first sale, assuming you lawfully acquired the GPL'd work in the
first place.

If the aggregation is performed in an automated and mechanized way, the
aggregate is not a single work. It's still multiple works aggregated
together. For copyright law purposes, it is not a work because no creative
input was needed to produce it beyond what was used to create the works from
which it was formed.

I recently bought two DVDs as a present for a friend of mine. I put the two
DVDs in one box and shipped them to him. Just because the two DVDs are in
one box does not make them a derivative work for copyright purposes because
no creative input went in to them. I can even staple the two DVDs together
if I want. I also don't need any special permission to ship the two of them
together to my friend, first sale covers that. The right to ship each
individual work is all that's needed to ship the aggregate.

Now, if I wanted to write my own story with elements from the content of
both DVDs, that would be a derivative work because the combination itself is
done in a creative way.

No automated, mechanical process can create a derivative work of software.
(With a few exceptions not relevant here.)

DS


