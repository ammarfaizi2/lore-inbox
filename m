Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTLERf7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbTLERf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:35:59 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:11035 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S264321AbTLERf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:35:57 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Ryan Anderson'" <ryan@michonline.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause?
Date: Fri, 5 Dec 2003 09:35:52 -0800
Organization: Cisco Systems
Message-ID: <001401c3bb56$3b2fdd40$ca41cb3f@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20031205140304.GF17870@michonline.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So far, I don't see any reason why a module that uses an 
> inline function provided via a kernel header could be distributed in
binary 
> format without being a "derived work" and thus bound by the GPL.

Yeah, the same reason that XFS, NUMA, etc are derived works from Unix
since they must include Unix header files.

What, maybe there are no inline functions there? No problem. SCO could
make stuff like spinlocks inline. And suddenly you are derived works
now.

I just don't see how this actually works as you said.


