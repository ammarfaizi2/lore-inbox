Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbSLFFI3>; Fri, 6 Dec 2002 00:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267600AbSLFFI3>; Fri, 6 Dec 2002 00:08:29 -0500
Received: from [202.54.40.198] ([202.54.40.198]:33691 "EHLO omega.zensar.com")
	by vger.kernel.org with ESMTP id <S267599AbSLFFI3> convert rfc822-to-8bit;
	Fri, 6 Dec 2002 00:08:29 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: WIN_READDMA
Date: Fri, 6 Dec 2002 10:43:14 +0530
Message-ID: <54670264D99F034EA23CBB7D7A45AE7E5ED7@zenmail1.ind.zensar.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: WIN_READDMA
Thread-Index: AcKc5rStUgjStgjPEdeMaAAIAl3PgA==
From: "Paresh Sawant" <p.Sawant@zensar.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Dec 2002 05:13:14.0431 (UTC) FILETIME=[2DC854F0:01C29CE6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi
    i want to send  "WIN_READDMA" ATA command to ide hard drive, i am doing ioctl call using command HDIO_DRIVE_TASK, what would be the third argument to the ioctl call ? currently i m passing following as third arg -
unsigned char args[8+512] = {WIN_READDMA,feature,sector_count,low_lba,mid_lba,high_lba,device,};

thanks
paresh

