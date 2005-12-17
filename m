Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbVLQPvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbVLQPvI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 10:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbVLQPvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 10:51:08 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:46145 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932595AbVLQPvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 10:51:06 -0500
X-IronPort-AV: i="3.99,263,1131350400"; 
   d="scan'208"; a="380021118:sNHT30805374"
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 00/13]  [RFC] IB: PathScale InfiniPath driver
X-Message-Flag: Warning: May contain useful information
References: <20051031150618.627779f1.akpm@osdl.org>
	<200512161548.jRuyTS0HPMLd7V81@cisco.com>
	<20051217131614.GB13043@infradead.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 17 Dec 2005 07:51:04 -0800
In-Reply-To: <20051217131614.GB13043@infradead.org> (Christoph Hellwig's
 message of "Sat, 17 Dec 2005 13:16:14 +0000")
Message-ID: <ada4q57k9hz.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 17 Dec 2005 15:51:06.0047 (UTC) FILETIME=[B0BABCF0:01C60321]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Christoph> Is there some political plot going where pathscale
    Christoph> folks are forcing you to send this out in this scheme?
    Christoph> Otherwise I couldn't explain the code quality
    Christoph> magnitudes lower than normally expected from your
    Christoph> merges.

No political plot -- this posting was an RFC in the literal sense,
with no expectation that the code is mergable as-is.  I just want to
get comments early so that we have a better idea of what needs to be
fixed.  For example, what's your feeling about sysctls in drivers?

BTW, Pathscale people -- please respond to the comments that are made
about your driver...

 - R.
