Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269419AbUI3TC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269419AbUI3TC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269415AbUI3TC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:02:58 -0400
Received: from gw.goop.org ([64.81.55.164]:28625 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S269421AbUI3TB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:01:28 -0400
Subject: RE: [PATCH] Fix for spurious interrupts on e100 resume
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, "Ronciak, John" <john.ronciak@intel.com>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <468F3FDA28AA87429AD807992E22D07E02B55EF6@orsmsx408>
References: <468F3FDA28AA87429AD807992E22D07E02B55EF6@orsmsx408>
Content-Type: text/plain
Date: Thu, 30 Sep 2004 12:01:24 -0700
Message-Id: <1096570884.3995.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 09:26 -0700, Venkatesan, Ganesh wrote:
> I propose that we remove this patch from the -mm tree. We will work on a
> clean solution and send a patch soon. Please see further discussion on
> this under the subject "2.6.9-rc2-mm4 e100 enable_irq unbalanced from"

Fine by me.  It was just a sleazy hack to prompt a proper fix.  I'm
using the eepro100 driver for a bit anyway, to see how it fares.

	J

