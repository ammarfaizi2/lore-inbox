Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWBYCnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWBYCnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 21:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWBYCnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 21:43:45 -0500
Received: from mta03.mail.t-online.hu ([195.228.240.56]:8440 "EHLO
	mta01.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S932505AbWBYCno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 21:43:44 -0500
From: "Szloboda Zsolt" <slobo@t-online.hu>
To: "Neil Brown" <neilb@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: raid over sata - write barrier
Date: Sat, 25 Feb 2006 03:43:39 +0100
Message-ID: <JDEMIGCBPIDENEAIIGKPCEFFCMAA.slobo@t-online.hu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <17317.57895.187139.651739@cse.unsw.edu.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

now we have 2.6.15
and I've mounted my ext3 file system with barrier=1 in fstab

is there a way to check if the whole stack (ext3 -> md > sd) actually
appreciates this setting?

