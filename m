Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWAEBkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWAEBkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWAEBkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:40:15 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:39051 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751136AbWAEBkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:40:14 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: gcoady@gmail.com
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pci_ids.h: remove duplicate IDs
Date: Thu, 05 Jan 2006 12:40:12 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <p5uor1lhum4ilra154o27e4vglvccd0v0a@4ax.com>
References: <1isor19fmroc4ue21gnqkp6k1ln1pp06r1@4ax.com>
In-Reply-To: <1isor19fmroc4ue21gnqkp6k1ln1pp06r1@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2006 12:14:16 +1100, Grant Coady <grant_lkml@dodo.com.au> wrote:

>
>From: Grant Coady <gcoady@gmail.com>
>
>pci_ids.h: removes eight duplicate IDs that crept in during the 
> 2.6.15 development cycle, commented a duplicate where one ID was 
> defined in terms of another.  Compile tested with allyesconfig.
>
>Signed-off-by: Grant Coady <gcoady@gmail.com>

Sorry gang, please scratch.  I'll wait for -mm1

Cheers,
Grant.

