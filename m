Return-Path: <linux-kernel-owner+w=401wt.eu-S932957AbWLSVeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932957AbWLSVeo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932959AbWLSVen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:34:43 -0500
Received: from amsfep16-int.chello.nl ([62.179.120.11]:45976 "EHLO
	amsfep16-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932957AbWLSVem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:34:42 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <Pine.LNX.4.64.0612191037291.3483@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <45876C65.7010301@yahoo.com.au>
	 <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
	 <45878BE8.8010700@yahoo.com.au>
	 <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
	 <4587B762.2030603@yahoo.com.au>
	 <Pine.LNX.4.64.0612190847270.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612190929240.3483@woody.osdl.org>
	 <Pine.LNX.4.64.0612191037291.3483@woody.osdl.org>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 22:30:28 +0100
Message-Id: <1166563828.10372.162.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 10:59 -0800, Linus Torvalds wrote:
> 
> On Tue, 19 Dec 2006, Linus Torvalds wrote:
> >
> >  here's a totally new tangent on this: it's possible that user code is 
> > simply BUGGY. 

I'm sad to say this doesn't trigger :-(


