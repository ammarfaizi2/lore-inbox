Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbUKBTwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUKBTwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUKBTpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:45:41 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:31879 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261429AbUKBTll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:41:41 -0500
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm2 and processes in D state
Date: Tue, 2 Nov 2004 20:41:28 +0100
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200411021612.41974.l_allegrucci@yahoo.it> <20041102123911.536fcc8e.akpm@osdl.org>
In-Reply-To: <20041102123911.536fcc8e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411022041.28311.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 November 2004 21:39, Andrew Morton wrote:
> Lorenzo Allegrucci <l_allegrucci@yahoo.it> wrote:
> >
> > 100% reproducible running LTP's 'runalltests.sh -x 100'.
> >  Below is the SysRq+T log after init 1 (to kill all killable processes).
> >  The processes which are stuck in D state are "genfmod" and "genlgamma".
> >  2.6.9 seems not to be affected.  2.6.10-rc1-bk* not tried.
> 
> Which filesystem is in use?

ext3

-- 
I route therefore you are
