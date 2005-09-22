Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbVIVEcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbVIVEcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 00:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbVIVEcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 00:32:22 -0400
Received: from xenotime.net ([66.160.160.81]:44517 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030210AbVIVEcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 00:32:22 -0400
Date: Wed, 21 Sep 2005 21:32:19 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: abonilla@linuxwireless.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch Question.
Message-Id: <20050921213219.090d63c5.rdunlap@xenotime.net>
In-Reply-To: <1127358091.5644.7.camel@localhost.localdomain>
References: <1127358091.5644.7.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005 21:01:31 -0600 Alejandro Bonilla Beeche wrote:

> Hi,
> 
> 	I have a couple of questions about sending patches. I did read the
> SubmittingPatches Doc but don't recall this.
> 
> Can anyone send a patch to LKML to be applied?

Anyone can send a patch.  Whether it gets applied depends on
several factors.

> How long does it normally take for a patch to be merged?

Depends on who you ask to merge it.  Andrew put patches into
the -mm patchset within minutes sometimes, depending on how
busy he is, what else he is doing, etc.

But it varies quite a bit by driver or subsystem maintainer.

> If a patch is not merged and I get no Replys, what should one do?

Send it to the correct maintainer (driver or subsystem usually).
If you can't find a correct maintainer, then send it to Andrew
(akpm@osdl.org).  Maybe put "[RFC]" in the Subject: line to
get (more) comments on it.

---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
