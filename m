Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWISBL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWISBL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 21:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWISBL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 21:11:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49317 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751295AbWISBL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 21:11:58 -0400
Date: Mon, 18 Sep 2006 21:10:46 -0400
From: Dave Jones <davej@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Ingo Molnar <mingo@elte.hu>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060919011046.GA25487@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	"Frank Ch. Eigler" <fche@redhat.com>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jes Sorensen <jes@sgi.com>, Andrew Morton <akpm@osdl.org>,
	Tom Zanussi <zanussi@us.ibm.com>,
	Richard J Moore <richardj_moore@uk.ibm.com>,
	Michel Dagenais <michel.dagenais@polymtl.ca>,
	Christoph Hellwig <hch@infradead.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	William Cohen <wcohen@redhat.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>, Ingo Molnar <mingo@elte.hu>,
	ltt-dev@shafik.org, systemtap@sources.redhat.com
References: <20060918234502.GA197@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918234502.GA197@Krystal>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 07:45:02PM -0400, Mathieu Desnoyers wrote:
 
 > + * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
 > + *
 > + * September 2006
 > + */
 > +
 > +#include <linux/config.h>
 > +#include <linux/kernel.h>

config.h is automatically included in the build process.
kernel.h is too iirc.
 
	Dave
