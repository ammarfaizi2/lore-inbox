Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266184AbUFPGPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266184AbUFPGPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 02:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUFPGPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 02:15:55 -0400
Received: from ip-65-77-168-70-muca.aerosurf.net ([65.77.168.70]:51433 "EHLO
	bedevere.spamaps.org") by vger.kernel.org with ESMTP
	id S266184AbUFPGPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 02:15:51 -0400
Subject: Re: PROBLEM: Heavy iowait on 2.6 kernels
From: Clint Byrum <cbyrum@spamaps.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1086942905.10540.69.camel@cronos.home.vsb>
References: <1086942905.10540.69.camel@cronos.home.vsb>
Content-Type: text/plain
Message-Id: <1087366549.1190.6.camel@lancelot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 15 Jun 2004 23:15:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-11 at 01:35, Guy Van Sanden wrote:
> I recently discovered why my new Gentoo server slows to a crawl on a
> intermediate load on the 2.6 kernel series.  The reason seems to be an
> unusual amount of iowait.

This appears similar to the problem both myself and Phy Prahbab reported
about 2.6 and hitting the disks too often. 

I'm wondering, what kind of workload does your machine see, and what
sort of disk system is in it?


