Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUEEGzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUEEGzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 02:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUEEGzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 02:55:19 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:3243 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263093AbUEEGzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 02:55:17 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: <linux-kernel@vger.kernel.org>
Subject: Can hugepages or a similar option be used as the pagecache for an NFS server instance?
Date: Wed, 5 May 2004 00:01:45 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQybtOex04YX/vvSPCdG6uXTT6rWQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <S263093AbUEEGzR/20040505065517Z+175@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way currently to make a linux system running an NFS server
instance store it's pagecache in 4mb pages?

--Buddy

