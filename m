Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTJMOGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 10:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbTJMOGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 10:06:32 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:53509 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261757AbTJMOGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 10:06:31 -0400
Date: Mon, 13 Oct 2003 15:06:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, jbarnes@sgi.com, pfg@sgi.com,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: [PATCH] Altix I/O code cleanup
Message-ID: <20031013150613.A30093@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com, jbarnes@sgi.com,
	pfg@sgi.com, linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
References: <3F872984.7877D382@sgi.com> <20031010215153.GA5328@sgi.com> <16263.14277.278807.472247@napali.hpl.hp.com> <20031013095824.B25495@infradead.org> <20031013035512.3859067d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031013035512.3859067d.akpm@osdl.org>; from akpm@osdl.org on Mon, Oct 13, 2003 at 03:55:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 03:55:12AM -0700, Andrew Morton wrote:
> Well there are two reasons for discouraging cleanups.  The first is of
> course that they can destabilise things.  But the other is that we want as
> many developers as possible (Hi, Jesse) concentrating on stabilisation.

Well, in this case we're talking about merging already existing patches..

