Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUDZPDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUDZPDN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUDZPDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:03:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7650 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261724AbUDZPDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:03:11 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Date: Mon, 26 Apr 2004 17:02:56 +0200
User-Agent: KMail/1.5.3
Cc: andersen@codepoet.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <20040426135058.GC14074@harddisk-recovery.com> <200404261650.40801.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200404261650.40801.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404261702.57138.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 26 of April 2004 16:50, Bartlomiej Zolnierkiewicz wrote:

> I want to rewrite+merge current IDE code with libata during 2.7
> (and yes, legacy naming and ordering will be preserved!).

as a config option not unconditionally

