Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTKKVcp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 16:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbTKKVco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 16:32:44 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:1524 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264292AbTKKVcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 16:32:43 -0500
Date: Tue, 11 Nov 2003 22:31:50 +0100 (MET)
From: Michal Kosmulski <M.Kosmulski@elka.pw.edu.pl>
To: John Bradford <john@grabjohn.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ASUS CD-ROM problem reading CD-RW
In-Reply-To: <200311111541.hABFfjX1000244@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.SOL.4.30.0311112224550.26013-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I own a 40x ASUS CD-ROM drive CD-S400 (this is an IDE drive but it runs
> > under ide-scsi).
>
> Why do you want to use it with IDE-SCSI?  Why not use it as a native
> IDE device?
I like k3b and other kde tools dealing with CDs and they require the use
of ide-scsi at least as far as I know (I tried to use cdrecord 2 without
ide-scsi with k3b but without success). I use k3b because I sometimes use
an external usb cd-recorder. However it is currently not connected to the
system.
Michal


