Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317436AbSFRO6m>; Tue, 18 Jun 2002 10:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317437AbSFRO6l>; Tue, 18 Jun 2002 10:58:41 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:8122 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S317436AbSFRO6k>; Tue, 18 Jun 2002 10:58:40 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F5110927E7A9E@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: VMM - freeing up swap space
Date: Tue, 18 Jun 2002 17:56:50 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Running an application allocating huge amounts of memory would push some
data from RAM to swap area. After the application terminates, swap area is
usually still occupied. 

Is there any way to clean up the swap area by pushing the data back to RAM?

Thanks in advance
Giga
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Gregory Giguashvili
Senior Software Engineer
Email: gregoryg@ParadigmGeo.com
Tel: 972-9-9709379 Fax: 972-3-9709337
Paradigm Geophysical Ltd.
http://www.math.tau.ac.il/~gregoryg


