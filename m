Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751848AbWDDLJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWDDLJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 07:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWDDLJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 07:09:27 -0400
Received: from www.osadl.org ([213.239.205.134]:29847 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751848AbWDDLJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 07:09:26 -0400
Subject: Re: [Patch 2/3] Mark block2mtd as not deprecated
From: Thomas Gleixner <tglx@linutronix.de>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org, "H. Peter Anvin" <hpa@zytor.com>,
       "Eric W. Biederman" <ebiederman@lnxi.com>,
       David Woodhouse <dwmw2@infradead.org>, Simon Evans <spse@secret.org.uk>
In-Reply-To: <20060404092930.GC12277@wohnheim.fh-wedel.de>
References: <20060404092628.GA12277@wohnheim.fh-wedel.de>
	 <20060404092930.GC12277@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=utf-8
Date: Tue, 04 Apr 2006 12:09:58 +0000
Message-Id: <1144152598.10601.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-04 at 11:29 +0200, Jörn Engel wrote:
> The last (and only) bugreport for this driver was > 1 year ago.  There
> is no reason to mark it as experimental anymore.
> 
> Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>

Acked-by: Thomas Gleixner <tglx@linutronix.de>


