Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUH2Nf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUH2Nf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267822AbUH2Nfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:35:55 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:51120 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267823AbUH2Nfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:35:41 -0400
Subject: Re: [patch] 2.6.9-rc1-mm1: megaraid_mbox.c compile error with gcc
	3.4
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Mukker, Atul" <Atulm@lsil.com>, bunk@fs.tum.de, sreenib@lsil.com,
       Manojj@lsil.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040828130419.57a56cdd.akpm@osdl.org>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC9BB@exa-atlanta> 
	<20040828130419.57a56cdd.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093742635.1670.5.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Aug 2004 09:34:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 16:04, Andrew Morton wrote:
> I dunno about James, but I *really* dislike receiving patches by going and
> getting them from internet servers.  It breaks our commonly-used tools.  It
> loses authorship info.  It loses Signed-off-by: info.  There is no
> changelog.  All this means that your patch is more likely to be ignored by
> busy people.  Please, just email the diffs.

Yes, I dislike it, but I've learned to live with downloading...

The Megaraid patch set, by the way, annoys me even more by not actually
applying to the kernel tree.  it doesn't reflect the fact that the
Changelog.megaraid is under Documentation/scsi not drivers/scsi.

However, it's all merged into the vanilla kernel now but in future, if
you could follow Andrew's guide, I'd be very grateful.

James


