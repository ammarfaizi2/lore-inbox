Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269779AbUJAMkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269779AbUJAMkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 08:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269777AbUJAMky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 08:40:54 -0400
Received: from mx1.magmacom.com ([206.191.0.217]:3976 "EHLO mx1.magmacom.com")
	by vger.kernel.org with ESMTP id S269776AbUJAMix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 08:38:53 -0400
Subject: Re: [sata] status report, libata-dev queue updated
From: Jesse Stockall <stockall@magma.ca>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041001045822.GA25784@havoc.gtf.org>
References: <20041001045822.GA25784@havoc.gtf.org>
Content-Type: text/plain
Message-Id: <1096634338.5688.4.camel@homer.blizzard.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 08:38:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 00:58, Jeff Garzik wrote:
> Notable updates:
> * new driver for ULi SATA (formerly ALi)
> * SMART support via ATA passthru CDB
> * support for Promise PATA ports

Yeah! the PATA controller is seen. I'll shutdown and stick a disk on the
controller and give it a whirl.

Thanks Eric and Jeff

Jesse

-- 
Jesse Stockall <stockall@magma.ca>

