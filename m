Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUEXWWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUEXWWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 18:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUEXWWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 18:22:14 -0400
Received: from slb-smtpout-01.boeing.com ([130.76.64.48]:38625 "EHLO
	slb-smtpout-01.boeing.com") by vger.kernel.org with ESMTP
	id S264717AbUEXWWD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 18:22:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Modifying kernel so that non-root users have some root capabilities
Date: Mon, 24 May 2004 15:21:56 -0700
Message-ID: <67B3A7DA6591BE439001F2736233351202B47E6F@xch-nw-28.nw.nos.boeing.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Modifying kernel so that non-root users have some root capabilities
Thread-Index: AcRB3YXo5LZC62pMQJ+B66/HI+3sVg==
From: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 May 2004 22:21:57.0193 (UTC) FILETIME=[866AA390:01C441DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(not sure if this is a duplicate or not.. Apologies in advance.)

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



