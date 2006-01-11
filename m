Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWAKRLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWAKRLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWAKRLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:11:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751366AbWAKRLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:11:51 -0500
Date: Wed, 11 Jan 2006 09:11:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: qiyong@fc-cn.com, linux-kernel@vger.kernel.org
Subject: Re: why no -mm git tree?
Message-Id: <20060111091125.716bfcfc.akpm@osdl.org>
In-Reply-To: <4d8e3fd30601110436p286cfacap6618067c32e22a32@mail.gmail.com>
References: <20060111055616.GA5976@localhost.localdomain>
	<20060110224451.44c9d3da.akpm@osdl.org>
	<20060111070043.GA7858@localhost.localdomain>
	<20060110231818.6164dba7.akpm@osdl.org>
	<4d8e3fd30601110436p286cfacap6618067c32e22a32@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
>
> > Ah.  If you're suggesting that the -mm git tree have _patches_ under git,
>  > and the way of grabbing the -mm tree is to pull everything and to then
>  > apply all the patches under the patches/ directory then yeah, that would
>  > work.
>  >
>  > But my tree at any random point in time is a random piece of
>  > doesn't-even-compile-let-alone-run crap, believe me.  Often not all the
>  > patches even apply.  I don't think there's much point in exposing people to
>  > something like that.
> 
>  Andew,
>  did you consider Stacked GIT as an alternative to quilt ?

I looked at the web page - stgit seems to be broken-out patches
revision-controlled under git.  I don't think that affects any of the
considerations I've outlined?
