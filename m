Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUHBSmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUHBSmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 14:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUHBSmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 14:42:40 -0400
Received: from the-village.bc.nu ([81.2.110.252]:45748 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261169AbUHBSmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 14:42:39 -0400
Subject: Re: OLS and console rearchitecture
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Schwab <schwab@suse.de>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <je3c35qznz.fsf@sykes.suse.de>
References: <20040802142416.37019.qmail@web14923.mail.yahoo.com>
	 <410E55AA.8030709@ums.usu.ru> <celori$joe$1@news.cistron.nl>
	 <je3c35qznz.fsf@sykes.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091468401.806.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 02 Aug 2004 18:40:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-02 at 17:21, Andreas Schwab wrote:
> > A configuration file for killall5 in which services/daemons get
> > defined that should not be signalled ?
> 
> IMHO a better solution would be some kind of process flag that can be
> interrogated by killall5.

Policy belongs in user space. This is entirely policy and personal
preference.

