Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267734AbUJLUUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267734AbUJLUUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 16:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267737AbUJLUUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 16:20:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:52173 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267734AbUJLUUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 16:20:38 -0400
Date: Tue, 12 Oct 2004 13:20:27 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Rik van Riel <riel@redhat.com>
cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org
Subject: Re: NUMA: Patch for node based swapping
In-Reply-To: <Pine.LNX.4.44.0410121151220.13693-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0410121319510.5785@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0410121151220.13693-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Rik van Riel wrote:

> On Tue, 12 Oct 2004, Christoph Lameter wrote:
>
> > Any other suggestions?
>
> Since this is meant as a stop gap patch, waiting for a real
> solution, and is only relevant for big (and rare) systems,
> it would be an idea to at least leave it off by default.
>
> I think it would be safe to assume that a $100k system has
> a system administrator looking after it, while a $5k AMD64
> whitebox might not have somebody watching its performance.

Ok. Will do that then. Should I submit the patch to Andrew?
