Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWCXQeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWCXQeW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 11:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWCXQeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 11:34:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41346 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932459AbWCXQeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 11:34:21 -0500
Date: Fri, 24 Mar 2006 11:34:11 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Stone Wang <pwstone@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][5/8] proc: export mlocked pages info through "/proc/meminfo:
 Wired"
In-Reply-To: <442098B6.5000607@yahoo.com.au>
Message-ID: <Pine.LNX.4.63.0603241133550.30426@cuia.boston.redhat.com>
References: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>  <441FEFC7.5030109@yahoo.com.au>
 <bc56f2f0603210733vc3ce132p@mail.gmail.com> <442098B6.5000607@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006, Nick Piggin wrote:

> Why would you want to ever do something like that though? I don't think 
> you should use this name "just in case", unless you have some really 
> good potential usage in mind.

ramfs

-- 
All Rights Reversed
