Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbUDBQjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 11:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbUDBQjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 11:39:42 -0500
Received: from adsl-64-109-89-108.dsl.chcgil.ameritech.net ([64.109.89.108]:17793
	"EHLO redscar") by vger.kernel.org with ESMTP id S264099AbUDBQjk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 11:39:40 -0500
Subject: RE: HSG80 entry in drivers/scsi/scsi_scan.c
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Dupuis, Chad" <chad.dupuis@hp.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <A8B003DDA3332A479C0ECCA641F47E6503BE6718@tayexc13.americas.cpqcorp.net>
References: <A8B003DDA3332A479C0ECCA641F47E6503BE6718@tayexc13.americas.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 02 Apr 2004 11:39:30 -0500
Message-Id: <1080923971.1804.76.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-02 at 09:47, Dupuis, Chad wrote:
> Ok, thank you.

For 2.6, can you first of all verify that the HSG80 won't work without
the BLIST_FORCELUN removed and CONFIG_SCSI_REPORT_LUNS enabled?  (If I
remember, this is a pretty old array, so probably won't, but just make
sure).

Thanks,

James


