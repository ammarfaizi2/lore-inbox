Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVBDK0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVBDK0e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVBDK0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:26:33 -0500
Received: from mail1.kontent.de ([81.88.34.36]:54453 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263302AbVBDK01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:26:27 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
Date: Fri, 4 Feb 2005 11:26:14 +0100
User-Agent: KMail/1.7.1
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050122134205.GA9354@wsc-gmbh.de> <4202DF7B.2000506@gmx.net> <20050204074802.GD1086@elf.ucw.cz>
In-Reply-To: <20050204074802.GD1086@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502041126.14386.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 4. Februar 2005 08:48 schrieb Pavel Machek:
> What about simply blocking all video accesses before disk (etc) is
> resumed, so that "normal" (not locked in memory) application can be
> used?

Very bad for debugging. Genuine serial ports are becoming rarer.

	Regards
		Oliver
