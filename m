Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318165AbSGWSDW>; Tue, 23 Jul 2002 14:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318166AbSGWSDW>; Tue, 23 Jul 2002 14:03:22 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:54112 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S318165AbSGWSDV>; Tue, 23 Jul 2002 14:03:21 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F511092E114A6@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "'Dr. Michael Weller'" <eowmob@exp-math.uni-essen.de>
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Problem with msync system call
Date: Tue, 23 Jul 2002 21:04:02 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>So, my guess would be your clocks are out of sync, hence the 
>copies of the network shared file are. (you know, like: server clock is
some
>hours/minutes behind the clients so each client thinks IT has the most
>actual copy of the file)
The clocks were out of sync, indeed. I tried to sync them and still the same
problem persists...

Thanks a lot for your help.
Giga
