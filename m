Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUCEVUc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUCEVUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:20:32 -0500
Received: from havoc.gtf.org ([216.162.42.101]:9658 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262078AbUCEVUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:20:31 -0500
Date: Fri, 5 Mar 2004 16:20:30 -0500
From: David Eger <eger@havoc.gtf.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UTF-8ifying the kernel source
Message-ID: <20040305212030.GA22211@havoc.gtf.org>
References: <20040304100503.GA13970@havoc.gtf.org> <buovfljbsyl.fsf@mcspd15.ucom.lsi.nec.co.jp> <c2ambg$9rs$1@terminus.zytor.com> <4048EA87.1080304@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4048EA87.1080304@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 01:00:55PM -0800, Mike Fedyk wrote:
> 
> So when is "less" going to support utf8?  Right now, it just shows 
> escape codes... :(

bash user? try:
$ export LESSCHARSET="utf-8"
$ less myfavoritefile.c

-dte ;-)
