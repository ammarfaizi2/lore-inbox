Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752138AbWCGKnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbWCGKnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 05:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbWCGKnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 05:43:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54410 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752123AbWCGKny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 05:43:54 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060306214357.0b299686.akpm@osdl.org> 
References: <20060306214357.0b299686.akpm@osdl.org>  <20060303045651.1f3b55ec.akpm@osdl.org> <200603052354.02828.dominik.karall@gmx.net> 
To: Andrew Morton <akpm@osdl.org>
Cc: Dominik Karall <dominik.karall@gmx.net>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>, David Howells <dhowells@redhat.com>
Subject: Re: 2.6.16-rc5-mm2 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 07 Mar 2006 10:43:26 +0000
Message-ID: <15253.1141728206@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > Here is another bug I got after mounting /mnt/extHDD2 a second time (it was 
> > already mounted).
> 
> What type of filesystem is that?  ext3?

That's updated in my latest patch which you've seen.

David

