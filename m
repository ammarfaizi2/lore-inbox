Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVA2SXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVA2SXW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 13:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVA2SXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 13:23:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:25798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261330AbVA2SXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 13:23:18 -0500
Date: Sat, 29 Jan 2005 10:23:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, michal@logix.cz
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
 crypto_tfm
Message-Id: <20050129102310.4bad9553.akpm@osdl.org>
In-Reply-To: <1107022416.25076.21.camel@ghanima>
References: <Xine.LNX.4.44.0501251042020.26690-100000@thoron.boston.redhat.com>
	<1107022416.25076.21.camel@ghanima>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens <clemens@endorphin.org> wrote:
>
> My advise is, drop Michaels patches
>  for now, merge scatterwalker and add an ability to change the stepsize
>  dynamically in the run. Then I will finish my port and post it.
> 
>  If we can agree on this "agenda", I'll shift my focus to scatterwalker
>  testing.

Sure.  Just work against Linus's tree.
