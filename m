Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVETS3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVETS3L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 14:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVETS3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 14:29:11 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:37908 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S261532AbVETS3J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 14:29:09 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: vm86 question
Date: Fri, 20 May 2005 11:28:55 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C3150485@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: vm86 question
Thread-Index: AcVdacgFUj6CIjLOQjeI87Yzny2eSQ==
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 May 2005 18:29:08.0951 (UTC) FILETIME=[CFD1CE70:01C55D69]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  vm86 seems to 'forget' (mask out) virtual interrupt pending flag (VIP)
on exit - for example, due to software interrupt. Is it a bug or a
feature ?

Thanks,
Aleks.
