Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271110AbTHCKHV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271120AbTHCKHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:07:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:50664 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271110AbTHCKHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:07:19 -0400
Date: Sun, 3 Aug 2003 03:08:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM problem leads to laptop freeze
Message-Id: <20030803030827.07334724.akpm@osdl.org>
In-Reply-To: <20030803100032.GA1242@eugeneteo.net>
References: <20030803091115.GA781@eugeneteo.net>
	<20030803100032.GA1242@eugeneteo.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Teo <eugene.teo@eugeneteo.net> wrote:
>
> <quote sender="Eugene Teo">
> > Hi everyone,
> > 
> > I was using kernel 2.6.0-test2-mm3. As usual, I anticipated that
> > I will have a random freeze, and true enough, I have one after a
> > few hours.
> > 
> > I have attached the log. Please take a look, and advise.
> > 
> Please let me know if you need more info other than my logs. I am
> all here to provide any relevant information so that this can be
> fixed :/

Can't suggest much really.

- see if it happens on another machine

- deconfigure unessential kernel features.  Start out with an utterly
  minimum config to boot, see if that's stable.  If so, start adding things
  back in until it fails.

