Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271225AbTHRFuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 01:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271239AbTHRFuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 01:50:08 -0400
Received: from mail.cid.net ([193.41.144.34]:39112 "EHLO mail.cid.net")
	by vger.kernel.org with ESMTP id S271225AbTHRFuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 01:50:06 -0400
Date: Mon, 18 Aug 2003 07:48:51 +0200
From: Stefan Foerster <stefan@stefan-foerster.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very bad interactivity with 2.6.0 and SCSI disks (aic7xxx)
Message-ID: <20030818054851.GA5252@in-ws-001.cid-net.de>
References: <20030818013243.GB21665@in-ws-001.cid-net.de> <20030817192103.798994d8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030817192103.798994d8.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> wrote:
> Stefan Foerster <stefan@stefan-foerster.de> wrote:
> A kernel profile would be needed to diagnose this.  You could use
> readprofile, but as it may be an interrupt problem, the NMI-based oprofile
> output would be better.

Is this procedure documented anywhere?


Ciao,
Stefan
-- 
Stefan Förster                                  Public Key: 0xBBE2A9E9
FdI #276: SMP - Fehlfunktion bei mehr als einer CPU. (nach Holger Veit)

