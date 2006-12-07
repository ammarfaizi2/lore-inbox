Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968783AbWLGEr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968783AbWLGEr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 23:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968781AbWLGEr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 23:47:27 -0500
Received: from mout0.freenet.de ([194.97.50.131]:42945 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968780AbWLGEr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 23:47:26 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: sergio@sergiomb.no-ip.org
Subject: Re: [patch] ACPI, i686, x86_64: fix laptop bootup hang in init_acpi()
Date: Thu, 7 Dec 2006 05:47:55 +0100
User-Agent: KMail/1.9.5
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20061206223025.GA17227@elte.hu> <1165458527.16955.58.camel@monteirov>
In-Reply-To: <1165458527.16955.58.camel@monteirov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612070547.56436.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 7. Dezember 2006 03:28 schrieb Sergio Monteiro Basto:
> On Wed, 2006-12-06 at 23:30 +0100, Ingo Molnar wrote:
> > Subject: [patch] ACPI, i686, x86_64: fix laptop bootup hang in init_acpi()
> > From: Ingo Molnar <mingo@elte.hu>
> Hi Ingo,
> Just curiosity ,have we this patch on 2.6.19-1.rt6 ?

No, its in rt7.

      Karsten
