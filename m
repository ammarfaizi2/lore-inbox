Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbULFO4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbULFO4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 09:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbULFO4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 09:56:37 -0500
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:24446 "EHLO
	exil1.paradigmgeo.net") by vger.kernel.org with ESMTP
	id S261496AbULFO4f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 09:56:35 -0500
Content-class: urn:content-classes:message
Subject: Correctly determine amount of "free memory"
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Mon, 6 Dec 2004 16:53:34 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <06EF4EE36118C94BB3331391E2CDAAD9CD060A@exil1.paradigmgeo.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Correctly determine amount of "free memory"
Thread-Index: AcTbo1xg0+eMREUXTQi3uNSWqE2icA==
From: "Gregory Giguashvili" <Gregoryg@ParadigmGeo.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Assuming that I define "free memory" as maximum memory that can be
allocated without causing swapping, is there a way I can give the best
"free memory" amount estimate?

I've tried to play with /proc/meminfo values with some progress, but I'd
like to get a qualified answer from people working with VM bits and
bytes.

Thanks a lot
Giga
