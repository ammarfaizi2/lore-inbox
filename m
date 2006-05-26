Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWEZHJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWEZHJo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWEZHJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:09:44 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:32664 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751330AbWEZHJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:09:43 -0400
Message-ID: <348627380.10566@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 26 May 2006 15:09:43 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, joern@wohnheim.fh-wedel.de,
       ioe-lkml@rameria.de
Subject: Re: [PATCH 09/33] readahead: events accounting
Message-ID: <20060526070943.GD5135@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	joern@wohnheim.fh-wedel.de, ioe-lkml@rameria.de
References: <20060524111246.420010595@localhost.localdomain> <348469540.16036@ustc.edu.cn> <20060525093627.4d37e789.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525093627.4d37e789.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 09:36:27AM -0700, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > A debugfs file named `readahead/events' is created according to advises from
> >  J?rn Engel, Andrew Morton and Ingo Oeser.
> 
> If everyone's patches all get merged up we'd expect that this facility be
> migrated over to use Martin Peschke's statistics infrastructure.
> 
> That's not a thing you should do now, but it would be a useful test of
> Martin's work if you could find time to look at it and let us know whether
> the infrastructure which he has provided would suit this application,
> thanks.

Sure, I'll look into it when I am able to settle down.

Wu
