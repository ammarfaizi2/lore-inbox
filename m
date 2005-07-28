Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVG1JCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVG1JCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 05:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVG1JCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 05:02:37 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:50348 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261392AbVG1JCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:02:36 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.32-pre2
Date: Thu, 28 Jul 2005 19:02:30 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <2i7he1lgg2237n66ec5p3e007tdsjos531@4ax.com>
References: <20050727080512.GD7368@dmt.cnet>
In-Reply-To: <20050727080512.GD7368@dmt.cnet>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005 05:05:12 -0300, Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
>Here goes another -pre, after a long period.

Breaks Toshiba laptop: hard lockup --> what is on screen is same as 
working dmesg up to point: "host/uhci.c: detected 2 port"

Same .config as for 2.4.31-hf3 or 2.4.32-pre1
http://scatter.mine.nu/test/linux-2.4/tosh/

Grant.

