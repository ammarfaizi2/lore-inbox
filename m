Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbTIRQjt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 12:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbTIRQjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 12:39:49 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:37864 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261663AbTIRQjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 12:39:47 -0400
Date: Thu, 18 Sep 2003 12:39:45 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: linux-kernel@vger.kernel.org, <linux-admin@vger.kernel.org>
Subject: Re: DON'T use DNS BLs,  they appear to be dying fast...
In-Reply-To: <20030916091303.GU9192@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.44.0309181238180.32280-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Matti Aarnio wrote:

> Or rather..   lattest thing to raise its ugly head is
>     dorkslayers.com
> which in itself, and in all its subdomains ("*.dorkslayers.com")
> points to Verisign's web service.

Well yeah, dorkslayers seems to have been down for over a
year now, the domain expiring etc...

Still, I don't think it's fair of you to blame the DNSBL
operators for the fact that some mail admins only check
their MTA configuration once every 2 years.

There have been cases where a DNSBL still got 1Mbit/s in
DNS queries 6 months after the database went dead...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

