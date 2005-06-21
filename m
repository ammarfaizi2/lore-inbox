Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVFUUOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVFUUOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVFUUMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:12:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37519 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262298AbVFUULx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:11:53 -0400
Date: Tue, 21 Jun 2005 13:11:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-Id: <20050621131132.105ea76f.akpm@osdl.org>
In-Reply-To: <20050621151019.GA19666@kroah.com>
References: <20050621062926.GB15062@kroah.com>
	<20050620235403.45bf9613.akpm@osdl.org>
	<20050621151019.GA19666@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
>  Or I can wait until you go next.  I didn't want these patches in the -mm
>  tree as they would have caused you too much work to keep up to date and
>  not conflict with anything else due to the size of them.

What happens if we merge it and then the storm of complaints over the
ensuing four weeks makes us say "whoops, shouldna done that [yet]"?
