Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030701AbWAKAEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030701AbWAKAEu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030702AbWAKAEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:04:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30848 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030701AbWAKAEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:04:48 -0500
Date: Tue, 10 Jan 2006 16:03:24 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: State of the Union: Wireless
Message-Id: <20060110160324.17074fa3.zaitcev@redhat.com>
In-Reply-To: <mailman.1136898727.7233.linux-kernel2news@redhat.com>
References: <43C3AAE2.1090900@cubic.ch>
	<mailman.1136898727.7233.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006 13:53:57 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> On Tue, Jan 10, 2006 at 01:38:58PM +0100, Tim Tassonis wrote:
> >...
> > >We can always undo mistakes later, but 
> > >we'll never get to that point if we don't start moving in one direction 
> > >instead of ten.
> > 
> > You were right if there were ten, but there seem to be only two at the 
> > moment. One stack will survive and one will die. There's no point in 
> > deciding this now.
> 
> No, we'll end up with two stacks, some drivers using the first stack and 
> some the second one.
> 
> You can't simply let one stack die because this would imply either 
> rewriting all drivers using this stack or dropping support for some 
> hardware.

So, you don't want to remove OSS drivers anymore, I take it.
Can't let bad stacks die!

-- Pete
