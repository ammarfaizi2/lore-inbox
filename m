Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbUK3Gve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUK3Gve (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 01:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUK3Gve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 01:51:34 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52180 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261982AbUK3Gvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 01:51:33 -0500
Date: Tue, 30 Nov 2004 07:51:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root
In-Reply-To: <1101765555l.13519l.1l@werewolf.able.es>
Message-ID: <Pine.LNX.4.53.0411300750310.23587@yvahk01.tjqt.qr>
References: <1101763996l.13519l.0l@werewolf.able.es>
 <Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr> <1101765555l.13519l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>dev=ATAPI uses ide-scsi interface, through /dev/sgX. And:

I do not have the ide-scsi.ko module even compiled, and it works.
The ATA: scanbus thing works for me as a normal user too (forgot to add that)


-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
