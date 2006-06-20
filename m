Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWFTT4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWFTT4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 15:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWFTT4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 15:56:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750838AbWFTT4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 15:56:11 -0400
Date: Tue, 20 Jun 2006 12:55:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: nickpiggin@yahoo.com.au, torvalds@osdl.org, teigland@redhat.com,
       pcaulfie@redhat.com, kanderso@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-Id: <20060620125539.7c2cc470.akpm@osdl.org>
In-Reply-To: <1150818052.3856.1399.camel@quoit.chygwyn.com>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	<4497EAC6.3050003@yahoo.com.au>
	<1150807630.3856.1372.camel@quoit.chygwyn.com>
	<44980064.6040306@yahoo.com.au>
	<1150818052.3856.1399.camel@quoit.chygwyn.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 16:40:52 +0100
Steven Whitehouse <swhiteho@redhat.com> wrote:

> > It seems as though you could explicitly control readahead more optimally,
> > but I don't know what the best way to do that would be. I assume Andrew
> > has had a quick look and doesn't know either.
> > 
> I'm not sure if he has looked at this specifically,

No, I haven't made time to look at the GFS2 code at all, really.
