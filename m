Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTFGWPE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 18:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTFGWPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 18:15:04 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:30458 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263921AbTFGWPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 18:15:02 -0400
Date: Sat, 7 Jun 2003 18:28:46 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Colin Paul Adams <colin@colina.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Maximum swap space?
In-Reply-To: <ltptlqb72n.fsf@colina.demon.co.uk>
Message-ID: <Pine.LNX.4.44.0306071827450.24170-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jun 2003, Colin Paul Adams wrote:

> I am somewhat confused about how much swap space you can have with a
> 2.4 series kernel. If I read the mkswap man page, I get the impression
> that I could have up to 8x2GB of swap space for a total of 16 GB, but
> reading the RedHat reference guide, it says 2GB maximum.

That piece of documentation is out of date.  I'm using a
20 GB swap partition on one of my test systems, with a
2.4 kernel.


