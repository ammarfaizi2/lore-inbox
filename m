Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264900AbUGBTvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbUGBTvF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 15:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUGBTvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 15:51:05 -0400
Received: from hera.kernel.org ([63.209.29.2]:41877 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264900AbUGBTvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 15:51:00 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: BitKeeper question
Date: Fri, 2 Jul 2004 12:50:47 -0700
Organization: Open Source Development Lab
Message-ID: <20040702125047.1a873f6a@dell_ss3.pdx.osdl.net>
References: <5ce509fc0407021228277c3bfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1088797847 2766 172.20.1.60 (2 Jul 2004 19:50:47 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 2 Jul 2004 19:50:47 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2004 12:28:42 -0700
Steve Best <creamygoodness@gmail.com> wrote:

> Hi folks, I am looking to programatically pull the latest snapshot of
> the bitkeeper repository on a daily basis, and also track all changes
> to the tree.  I downloaded BitKeeper and was wondering how I configure
> it to achieve this.  I dont need specific commands, I can look those
> up myself in the documentation, I am looking for configuration
> settings.

cron
