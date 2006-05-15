Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWEOOIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWEOOIG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWEOOIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:08:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31117 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964928AbWEOOIE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:08:04 -0400
Subject: Re: how to set this in the future
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen.Clark@seclark.us
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4466437C.1070306@seclark.us>
References: <4466437C.1070306@seclark.us>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 15:20:48 +0100
Message-Id: <1147702848.26686.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-05-13 at 16:37 -0400, Stephen Clark wrote:
> Hello List,
> 
> I need to use ide0=ata66 but I get the following:
> 
> ide_setup: ide0=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
> 
> what will replace this option?

drivers/scsi/libata .. if I have anything to do with it 8)

Why do you need to use ide0=ata66. What is the hardware requirement that
causes this ?

Alan

