Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270013AbTGZVPs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269969AbTGZVPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:15:48 -0400
Received: from zork.zork.net ([64.81.246.102]:64747 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S270013AbTGZVPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:15:42 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] use ext2/ext3 consistently in Kconfig
References: <20030726195722.GB16160@louise.pinerecords.com>
	<200307261621.55553.jeffpc@optonline.net>
	<6ud6fx118p.fsf@zork.zork.net>
	<20030726212128.GB16798@louise.pinerecords.com>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sat, 26 Jul 2003 22:30:54 +0100
In-Reply-To: <20030726212128.GB16798@louise.pinerecords.com> (Tomas Szepe's
 message of "Sat, 26 Jul 2003 23:21:28 +0200")
Message-ID: <6uwue5ynzl.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hate to drag this out further...

Tomas Szepe <szepe@pinerecords.com> writes:

> -	  This is the journaling version of the Second extended file system
> -	  (often called ext3), the de facto standard Linux file system
> -	  (method to organize files on a storage device) for hard disks.
> +	  Ext3 is a jornaling version of the Second extended fs

s/jornaling/journaling/

