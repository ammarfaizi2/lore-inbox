Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTIYNkU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 09:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbTIYNkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 09:40:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26562 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261217AbTIYNkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 09:40:16 -0400
Date: Thu, 25 Sep 2003 14:40:15 +0100 (BST)
From: marcelo@parcelfarce.linux.theplanet.co.uk
To: Andrea Arcangeli <andrea@suse.de>
cc: Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: log-buf-len dynamic
In-Reply-To: <20030922194833.GA2732@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0309251436320.30864-100000@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Sep 2003, Andrea Arcangeli wrote:

> Hi,
> 
> I'm rejecting on the log-buf-len feature in 2.4.23pre5, the code in
> mainline is worthless for any distributor, shipping another rpm package
> just for the bufsize would be way overkill.

Andrea,

As Willy stated previously this is useful for people who want to change 
the log buf size without having to change the code manually, and I think 
this is a useful and non intrusive change.

Do you see any problem with this? 

