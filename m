Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751845AbWCIVar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbWCIVar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 16:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWCIVar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 16:30:47 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:40760 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751845AbWCIVaq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 16:30:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sNCO11EVznyBX943nSdGX9xHB8WKTaoVt+Wdje9bT1IgEdEO1zd7nVbvW4fsUwOlwC3E1MTast8KKX+DrtFayKAmg9hX2UXnN0HMfW6QUijTpkCBlgJkh3npTMLTYl0OsHRNY/OqNkmd83WlG837lx4K0syyGx6r/ZGuLUrO9SU=
Message-ID: <161717d50603091330j61850529xcd50382a55ccb6b3@mail.gmail.com>
Date: Thu, 9 Mar 2006 16:30:45 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: [future of drivers?] a proposal for binary drivers.
Cc: Luke-Jr <luke@dashjr.org>, "Anshuman Gholap" <anshu.pg@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44108CCB.9080709@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
	 <200603091509.06173.luke@dashjr.org> <441057D4.6030304@cfl.rr.com>
	 <161717d50603090933o3df190f9vb1e06b0ec37deb8e@mail.gmail.com>
	 <44108CCB.9080709@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/06, Phillip Susi <psusi@cfl.rr.com> wrote:
>
> That is correct, the final decision is up to a Judge, but we aren't in
> court here, we're discussing it, and so I'm making an argument that I
> believe any sane judge would side with.
>
<snip>
>
> A "derivative work" is a work based upon one or more preexisting works,
> such as a translation, musical arrangement, dramatization,
> fictionalization, motion picture version, sound recording, art
> reproduction, abridgment, condensation, or any other form in which a
> work may be recast, transformed, or adapted. A work consisting of
> editorial revisions, annotations, elaborations, or other modifications,
> which, as a whole, represent an original work of authorship, is a
> "derivative work".
>
> No mention of either of your two conditions.

A "work based on one or more preexisting works [in] any other form in
which a work may be recast, transformed or adapted" sure sounds like
it fits someone compiling software with my symbols in it to me.
Elaboration sure sounds like it fits program code calling my program
code to me.

> You _might_ be able to
> argue that they use your headers to compile their driver, so that
> violates your copyright, but they are free to develop their own
> compatible headers to produce compatible binaries which are in no way
> derived from the Linux kernel.  See Wine's win32 compatible headers and
> libraries for examples of this.

I'm sorry, I don't think that analysis is correct for software, see
for example: http://community.linux.com/article.pl?sid=02/11/13/117247&tid=87&tid=41&tid=12&tid=42,
and Linus' previous explanations as I pointed out in my reply to
Xavier.

At any rate, at the moment I'm getting paid software, not for legal
analysis which I'm not qualified to give. I'm certainly not getting
paid enough to sue anyone, so unless some other kernel hacker or
company is planning on initiating a lawsuit (to which I'd happily
join) it's fairly moot, and I'll let it drop at that.

ciao,
Dave
