Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVCNOia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVCNOia (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 09:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVCNOia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 09:38:30 -0500
Received: from asia.telenet-ops.be ([195.130.132.59]:22216 "EHLO
	asia.telenet-ops.be") by vger.kernel.org with ESMTP id S261513AbVCNOi1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 09:38:27 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Call for help: list of machines with working S3
Date: Mon, 14 Mar 2005 15:39:13 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>, seife@suse.de,
       rjw@sisk.pl
References: <20050214211105.GA12808@elf.ucw.cz> <200503140719.01536.lkml@kcore.org> <20050314080029.GF22635@elf.ucw.cz>
In-Reply-To: <20050314080029.GF22635@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503141539.14018.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 March 2005 09:00, Pavel Machek wrote:
> Hi!
>
> >   * MySQL (hinders the actual suspension process and kicks the pc back to
> >     where it was)
>
> Try this patch...

Works nicely. Thanks.

Jan

-- 
Most people don't need a great deal of love nearly so much as they need
a steady supply.
