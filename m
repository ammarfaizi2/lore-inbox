Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUCPT5E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUCPT4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:56:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:28829 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261410AbUCPTza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:55:30 -0500
Date: Tue, 16 Mar 2004 11:53:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, bos@serpentine.com,
       linux-raid@vger.kernel.org
Subject: Re: [PATCH] klibc update
Message-Id: <20040316115340.361f2a14.akpm@osdl.org>
In-Reply-To: <40575631.1080006@pobox.com>
References: <4056B0DB.9020008@pobox.com>
	<20040316005229.53e08c0c.akpm@osdl.org>
	<20040316153719.GA13723@kroah.com>
	<20040316111026.6729e153.akpm@osdl.org>
	<40575279.7040408@pobox.com>
	<20040316192458.GB21172@kroah.com>
	<40575631.1080006@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
>  >>Note that it isn't my intention to become klibc maintainer...  just in 
>  >>case anybody started getting ideas... :)
>  > 
>  > 
>  > I thought hpa was the klibc maintainer, you're just offering a patch to
>  > add it to the build :)
> 
>  Right...  I meant I am not going to become the maintainer of said 
>  patch/BK tree :)

It would be rather handy if someone could maintain the definitive tree for
this work for a while, until we linusify it.

I don't have a feeling for its stability/readiness/desirability/anthingelse
at this stage.  How mergeable is it?
