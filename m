Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTIKPOG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbTIKPOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:14:03 -0400
Received: from [65.39.167.210] ([65.39.167.210]:38797 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S261356AbTIKPM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:12:27 -0400
Date: Thu, 11 Sep 2003 11:12:23 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Jens Axboe <axboe@suse.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Mike Fedyk <mfedyk@matchmail.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
In-Reply-To: <20030911082057.GP1396@suse.de>
Message-ID: <Pine.LNX.4.44.0309111111150.24179-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003, Jens Axboe wrote:

> On Wed, Sep 10 2003, Martin J. Bligh wrote:
> > That's a real shame ... it seemed to work fine until recently. Some
> > of the DVD writers (eg the one I have - Sony DRU500A or whatever)
>
> Then maybe it would be a really good idea to find out why it doesn't
> work with ide-cd. What are the symptoms?
>
> > need it. Is it unfixable? or just nobody's done it?
>
> It's not unfixable, there's just not a lot of motivation to fix it since
> it's basically dead.
>

What about backwards compatability with all of that cd burning software
out there that only knows to scan the SCSI devices?

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

