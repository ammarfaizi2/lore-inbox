Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbTJMI6k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 04:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTJMI6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 04:58:40 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:54543 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261582AbTJMI6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 04:58:39 -0400
Date: Mon, 13 Oct 2003 09:58:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: davidm@hpl.hp.com
Cc: Jesse Barnes <jbarnes@sgi.com>, Patrick Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com, akpm@osdl.org
Subject: Re: [PATCH] Altix I/O code cleanup
Message-ID: <20031013095824.B25495@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, davidm@hpl.hp.com,
	Jesse Barnes <jbarnes@sgi.com>, Patrick Gefre <pfg@sgi.com>,
	linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com,
	akpm@osdl.org
References: <3F872984.7877D382@sgi.com> <20031010215153.GA5328@sgi.com> <16263.14277.278807.472247@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16263.14277.278807.472247@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Fri, Oct 10, 2003 at 03:50:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 03:50:45PM -0700, David Mosberger wrote:
> >>>>> On Fri, 10 Oct 2003 14:51:53 -0700, jbarnes@sgi.com (Jesse Barnes) said:
> 
>   Jesse> David, please apply this set of patches from Pat.
> 
> Unfortunately, the 2.6 tree is closed for cleanups.  I would _like_ to
> see the patch applied, though.  Perhaps you could talk to Andrew and
> see if you can get an exception?

Sounds strange to apply this rule for a particular årchitectured that
just managed to compile again on 2.6 and has a huge backlog of cleanups
and restructuring now...

