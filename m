Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWDDLJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWDDLJV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 07:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWDDLJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 07:09:21 -0400
Received: from www.osadl.org ([213.239.205.134]:27799 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751848AbWDDLJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 07:09:21 -0400
Subject: Re: [Patch 3/3] Remove blkmtd
From: Thomas Gleixner <tglx@linutronix.de>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org, "H. Peter Anvin" <hpa@zytor.com>,
       "Eric W. Biederman" <ebiederman@lnxi.com>,
       David Woodhouse <dwmw2@infradead.org>, Simon Evans <spse@secret.org.uk>
In-Reply-To: <20060404093002.GD12277@wohnheim.fh-wedel.de>
References: <20060404092628.GA12277@wohnheim.fh-wedel.de>
	 <20060404093002.GD12277@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=utf-8
Date: Tue, 04 Apr 2006 12:09:52 +0000
Message-Id: <1144152592.10601.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-04 at 11:30 +0200, Jörn Engel wrote:
> o Remove the (very recently) deprecated blkmtd driver.
> o Move the Kconfig description over to block2mtd, its replacement.
> 
> Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de

Acked-by: Thomas Gleixner <tglx@linutronix.de>


