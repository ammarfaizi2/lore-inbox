Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbSLDJDj>; Wed, 4 Dec 2002 04:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbSLDJDj>; Wed, 4 Dec 2002 04:03:39 -0500
Received: from [202.54.40.198] ([202.54.40.198]:44283 "EHLO omega.zensar.com")
	by vger.kernel.org with ESMTP id <S266959AbSLDJDi> convert rfc822-to-8bit;
	Wed, 4 Dec 2002 04:03:38 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: struct to be passed to ioctl call for commanf HDIO_DRIVE_CMD
Date: Wed, 4 Dec 2002 14:38:18 +0530
Message-ID: <54670264D99F034EA23CBB7D7A45AE7E5ECD@zenmail1.ind.zensar.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: struct to be passed to ioctl call for commanf HDIO_DRIVE_CMD
Thread-Index: AcKbdTVmdvUCPgdFEdeMZgAIAl3PgA==
From: "Paresh Sawant" <p.Sawant@zensar.com>
To: <Majordomo@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-idel@vger.kernel.org>,
       <linux-c-programming@vger.kernel.org>
X-OriginalArrivalTime: 04 Dec 2002 09:08:18.0860 (UTC) FILETIME=[AFD9E6C0:01C29B74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
        I want to send ATA command to IDE hard disk driver using ioctl with comand "HDIO_DRIVE_CMD", to do raw write to hard disk. Which Struct i should pass to ioctl call as a third argument ?

thanks 
paresh
