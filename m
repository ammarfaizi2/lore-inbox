Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161139AbWI1ONl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbWI1ONl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 10:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbWI1ONl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 10:13:41 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:16833 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1161139AbWI1ONk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 10:13:40 -0400
Date: Thu, 28 Sep 2006 07:04:06 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 perfmon new code base + libpfm + pfmon
Message-ID: <20060928140406.GF18245@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060926143420.GF14550@frankl.hpl.hp.com> <20060926220951.39bd344f.akpm@osdl.org> <20060927224832.GA17883@frankl.hpl.hp.com> <20060928134126.GA14635@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928134126.GA14635@infradead.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chritoph,

On Thu, Sep 28, 2006 at 02:41:26PM +0100, Christoph Hellwig wrote:
> this completly leaves out my comments, which you also seemed to ignore before
> :)

It is true I forgot to list your comments in the summary I sent out yesterday.
However rest assured that I took them into account. If you noticed in my annoucement
for 2.6.18, I have removed the perfmon KAPI interface, for instance. As for the UUID
 to string conversion, this was also pointed out by Andrew and it is work-in-progress.

So here is the additional feedback I will put in the summary:

[hch]: remove perfmon kernel-level API (perfmon_kapi.c), it is not justified
	- done

[hch]: use strings insead of UUID
	- work in progress

In general, I do listen to comments. The summary of changes is a good proof
of that, I think.

Thanks.

-- 
-Stephane
