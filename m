Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbTAAVvY>; Wed, 1 Jan 2003 16:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbTAAVvY>; Wed, 1 Jan 2003 16:51:24 -0500
Received: from daimi.au.dk ([130.225.16.1]:53931 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S264799AbTAAVvY>;
	Wed, 1 Jan 2003 16:51:24 -0500
Message-ID: <3E1364D4.98C092AB@daimi.au.dk>
Date: Wed, 01 Jan 2003 22:59:48 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-17.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Guennadi Liakhovetski <lyakh@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi CD-recorder error reading burned disks
References: <Pine.LNX.4.44.0212312145020.3542-100000@poirot.grange>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> 
> After burning a CD, when trying to read I am getting the following
> behaviour:
> 
> ~> dd if=/dev/cdr of=/dev/null bs=2048
> dd: reading `/dev/cdr': Input/output error
> 176996+0 records in
> 176996+0 records out

I have seen similar problems before I started using the -dao option for
cdrecord.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
