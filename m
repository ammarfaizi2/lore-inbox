Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbTFCRKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 13:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTFCRKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 13:10:42 -0400
Received: from imsantv23.netvigator.com ([210.87.250.79]:22478 "EHLO
	imsantv23.netvigator.com") by vger.kernel.org with ESMTP
	id S261192AbTFCRKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 13:10:41 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Marc Wilson <msw@cox.net>
Subject: Re: Linux 2.4.21-rc6
Date: Wed, 4 Jun 2003 01:23:42 +0800
User-Agent: KMail/1.5.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20030529052425.GA1566@moonkingdom.net> <200306040030.27640.mflt1@micrologica.com.hk> <200306031859.59197.m.c.p@wolk-project.de>
In-Reply-To: <200306031859.59197.m.c.p@wolk-project.de>
X-OS: GNU/Linux 2.5.70
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306040123.42753.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 June 2003 00:59, Marc-Christian Petersen wrote:
> On Tuesday 03 June 2003 18:30, Michael Frank wrote:
> well, very easy one:
>
> dd if=/dev/zero of=/home/largefile bs=16384 count=131072

Got that already - more flexible:

http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/1291.html

Breaks anything >= 2.4.19 < rc6 in no time.

We need more - any ideas

Reagards
Michael

