Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWFNOPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWFNOPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWFNOPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:15:55 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:17070 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S964967AbWFNOPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:15:54 -0400
Date: Wed, 14 Jun 2006 16:15:37 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/8] lock validator: s390 support
Message-ID: <20060614141537.GA1241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

following is a series of patches needed to get the lock validator running
on s390. Patches are against linux-2.6.17-rc6-mm2
+ lockdep-combo-2.6.17-rc6-mm2.patch (from 13th of june).
Seems to work so far.

Heiko
