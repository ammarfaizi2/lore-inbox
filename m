Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTGHMly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTGHMly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:41:54 -0400
Received: from smtp0.libero.it ([193.70.192.33]:3998 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S261151AbTGHMlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:41:53 -0400
Subject: Re: 2.5.74-mm2 + nvidia (and others)
From: Flameeyes <dgp85@users.sourceforge.net>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <6A3BC5C5B2D@vcnet.vc.cvut.cz>
References: <6A3BC5C5B2D@vcnet.vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1057669044.918.1.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 08 Jul 2003 14:57:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-08 at 14:37, Petr Vandrovec wrote:
> Either copy compat_pgtable.h from vmmon to vmnet, or grab
> vmware-any-any-update36. I forgot to update vmnet's copy of this file.
also vmware-any-any-update36 doesn't work... works only if we copy also
pgtbl.h from vmmon to vmnet.
-- 
Flameeyes <dgp85@users.sf.net>

