Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265892AbUFISPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265892AbUFISPc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265894AbUFISPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:15:31 -0400
Received: from winds.org ([68.75.195.9]:25515 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S265892AbUFISPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:15:21 -0400
Date: Wed, 9 Jun 2004 14:15:19 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in ncpfs
In-Reply-To: <20040609122002.GD21168@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.60.0406091414140.14198@winds.org>
References: <20040609122002.GD21168@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1262750147-1680410027-1086804919=:14198"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1262750147-1680410027-1086804919=:14198
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

Jörn, do you have any analysis of stack usage for x86-64 or other 64-bit
processors? I assume they would more readily reach the 4K stack boundaries as
all longs and pointers are 8 bytes instead of 4.

Thanks,
  -Byron

--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com
--1262750147-1680410027-1086804919=:14198--
