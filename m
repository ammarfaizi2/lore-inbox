Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVCIMw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVCIMw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 07:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVCIMwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 07:52:25 -0500
Received: from bgerelbas02.asiapac.hp.net ([15.219.201.135]:36055 "EHLO
	bgerelbas02.ind.hp.com") by vger.kernel.org with ESMTP
	id S262344AbVCIMwX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 07:52:23 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Problem with DCE with Kernel Patch
Date: Wed, 9 Mar 2005 18:21:49 +0530
Message-ID: <3EB96D97711EAA45B291A31082CC865601511595@bgeexc04.asiapacific.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with DCE with Kernel Patch
Thread-Index: AcUkpsJ6XgcoeTkZRrW2x9T1tYfkWQ==
From: "Singal, Manoj Kumar (STSD)" <manoj-kumar.singal@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Mar 2005 12:51:50.0603 (UTC) FILETIME=[C314F9B0:01C524A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

While installing DCE 0.1.13 on RH Linux AS 2.1 Kernel 2.4.18-e.54smp
running on Itanium, the system hangs and becomes unbootable. It then has
to be started in single user mode, the dce rpm has to be removed and
then booted. This happens with kernel patch 52/54. 

Has anyone faced a similar problem and resolved it ? . Any pointers in
this regard will be really *nice*.

Thanks in advance.
-- 
Manoj

