Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266018AbUGVOs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbUGVOs2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 10:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266021AbUGVOs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 10:48:28 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:39145 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266018AbUGVOs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 10:48:26 -0400
Date: Thu, 22 Jul 2004 10:51:44 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops while shutting down (2.6.8rc1)
In-Reply-To: <200407221053.53735.m.watts@eris.qinetiq.com>
Message-ID: <Pine.LNX.4.58.0407221048390.19190@montezuma.fsmlabs.com>
References: <200407161011.36677.m.watts@eris.qinetiq.com>
 <Pine.LNX.4.58.0407201008460.21932@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0407201133520.23033@montezuma.fsmlabs.com>
 <200407221053.53735.m.watts@eris.qinetiq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2004, Mark Watts wrote:

> I had to apply it by hand for some reason (I'm not running -mm1 if that makes
> a difference), but it's fixed the problem :)
>
> Many Thanks

Thank you for confirming that, and it seems to have taken care of the
report on bugzilla too. The previous fix on bugzilla, i feel, is  too
complex. I'll get this one applied.

Ta,
	Zwane

