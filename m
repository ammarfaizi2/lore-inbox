Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSLJRNl>; Tue, 10 Dec 2002 12:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSLJRNk>; Tue, 10 Dec 2002 12:13:40 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:19426 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S263143AbSLJRMg> convert rfc822-to-8bit; Tue, 10 Dec 2002 12:12:36 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
To: Keith Owens <kaos@ocs.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF0AFE8361.10B08401-ONC1256C8B.005EE1A2@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Tue, 10 Dec 2002 18:17:05 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 10/12/2002 18:19:37
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> EX R1,syscall - instruction length is 4, not 2.
Another good reason not to go back to user space.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


