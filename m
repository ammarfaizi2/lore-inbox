Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWHBT7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWHBT7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWHBT7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:59:47 -0400
Received: from 1wt.eu ([62.212.114.60]:10765 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932209AbWHBT7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:59:16 -0400
Date: Wed, 2 Aug 2006 21:51:00 +0200
From: Willy Tarreau <w@1wt.eu>
To: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Message-ID: <20060802195100.GA16290@1wt.eu>
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <200607271521.38217.benjamin.cherian.kernel@gmail.com> <20060730003527.19bec8ce.zaitcev@redhat.com> <200607311141.29600.benjamin.cherian.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607311141.29600.benjamin.cherian.kernel@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin, Hi Pete,

On Mon, Jul 31, 2006 at 11:41:28AM -0700, Benjamin Cherian wrote:
> Hi Pete,
> 
> >How about now?
> 
> Much better! For me, everything seems to be working. No segfaults, and 
> everything seems to work.

That's very good news.

Pete, do you consider your work as appropriate for mainline ? In this
case, I can queue it for 2.4.34.

> Thanks,
> 
> Ben

Thanks guys,
Willy

