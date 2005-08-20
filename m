Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932807AbVHTDEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807AbVHTDEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 23:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932812AbVHTDEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 23:04:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932807AbVHTDEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 23:04:12 -0400
Date: Fri, 19 Aug 2005 20:02:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@suse.de, mingo@elte.hu
Subject: Re: [patch 2.6.13-rc6] i386: semaphore ownership tracking
Message-Id: <20050819200227.11177e16.akpm@osdl.org>
In-Reply-To: <200508192258_MC3-1-A7A8-D72@compuserve.com>
References: <200508192258_MC3-1-A7A8-D72@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
>  This patch enables tracking semaphore ownership.

Why?  I can't think of any bug in recent years which needed this..
