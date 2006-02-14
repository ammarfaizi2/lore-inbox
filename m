Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbWBNQcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWBNQcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbWBNQcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:32:35 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:721 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161123AbWBNQce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:32:34 -0500
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
From: Lee Revell <rlrevell@joe-job.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: Charles-Edouard Ruault <ce@ruault.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060214114102.GC20975@vanheusden.com>
References: <43EF8388.10202@ruault.com>
	 <20060214114102.GC20975@vanheusden.com>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 11:32:28 -0500
Message-Id: <1139934749.11659.97.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 12:41 +0100, Folkert van Heusden wrote:
> I've got the same soft lockups, not while cdrom access but when sa-learn
> runs (from spamassassin):

Why is DMA disabled for your IDE disks?

Lee

