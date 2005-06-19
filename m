Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVFSOxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVFSOxg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 10:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbVFSOxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 10:53:36 -0400
Received: from bay106-f13.bay106.hotmail.com ([65.54.161.23]:13429 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262240AbVFSOxe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 10:53:34 -0400
Message-ID: <BAY106-F13B31695A742EE813EFE26C8F60@phx.gbl>
X-Originating-IP: [65.54.161.200]
X-Originating-Email: [nchiellini@hotmail.com]
In-Reply-To: <42B45105.1060306@pobox.com>
From: "Nicolo Chiellini" <nchiellini@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: Re: PROBLEM: libata + sata_sil on sil3112 dosen't work proper
Date: Sun, 19 Jun 2005 16:53:33 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
X-OriginalArrivalTime: 19 Jun 2005 14:53:33.0445 (UTC) FILETIME=[AA0CBB50:01C574DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the fast reply,

>>I have a problem whit a raid controller using SATA SIL 3112 chipset, [..]

>This is not a RAID controller.
>http://linux.yyz.us/sata/faq-sata-raid.html#sii
>Jeff

You have reason about that but the problem is not on RAID Sw, is not even 
setted up atm and i need use it like SATA controller.
When i try to load sata_sil the system give problems describted on the first 
mail and, the worst think, if the modules is builded static on kernel the 
machine hang on boot time when it try to recognize the controller.
The same module work fine whit SIL 3114 and sata disks.

Thanks, Nicolo'


