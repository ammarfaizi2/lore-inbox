Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUEXWU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUEXWU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 18:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUEXWU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 18:20:59 -0400
Received: from blv-smtpout-01.boeing.com ([130.76.32.69]:8326 "EHLO
	blv-smtpout-01.boeing.com") by vger.kernel.org with ESMTP
	id S264704AbUEXWU5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 18:20:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 
Date: Mon, 24 May 2004 15:20:33 -0700
Message-ID: <67B3A7DA6591BE439001F2736233351202B47E6E@xch-nw-28.nw.nos.boeing.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Index: AcRB3VQgxH6dWpbwSEWi7nAbAR3R5g==
From: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 May 2004 22:20:33.0854 (UTC) FILETIME=[54BE1DE0:01C441DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been tasked with modifying a 2.4 kernel so that a non-root user can
do the following:

Dynamically change the priorities of processes (up and down)
Lock processes in memory
Can change process cpu affinity

Anyone got any ideas about how I could start doing this?  (I'm new to
kernel development, btw.)

Thanks,

Joe Laughlin
Phantom Works - Integrated Technology Development Labs 
The Boeing Company



