Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbTJBHC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 03:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTJBHC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 03:02:59 -0400
Received: from [61.95.227.64] ([61.95.227.64]:23454 "EHLO gateway.gsecone.com")
	by vger.kernel.org with ESMTP id S263263AbTJBHC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 03:02:58 -0400
Subject: Re: [PATCH 2.6.0-test6][X25] timer cleanup
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: Andrew Morton <akpm@osdl.org>
Cc: netdev@oss.sgi.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20031001155623.06b89258.akpm@osdl.org>
References: <1065018387.7194.336.camel@lima.royalchallenge.com>
	 <20031001155623.06b89258.akpm@osdl.org>
Content-Type: text/plain
Organization: Global Security One
Message-Id: <1065078208.4340.3.camel@lima.royalchallenge.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 02 Oct 2003 12:33:28 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-02 at 04:26, Andrew Morton wrote:
> Vinay K Nallamothu <vinay.nallamothu@gsecone.com> wrote:
> >
> > Replace del_timer, mod_timer sequences with mod_timer.
> 
> was this tested?
No. But compiles fine.

