Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271231AbTHCStr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 14:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271233AbTHCSsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 14:48:39 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:43425 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S271235AbTHCSsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 14:48:05 -0400
Subject: Re: 2.4.22pre10-ac1: ICH5 SATA missing in action
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F2D53E8.7070700@pobox.com>
References: <1059934705.2789.8.camel@paragon.slim>
	 <3F2D53E8.7070700@pobox.com>
Content-Type: text/plain
Message-Id: <1059936398.2789.11.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-1) 
Date: 03 Aug 2003 20:46:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-03 at 20:26, Jeff Garzik wrote:

> The -ac tree defaults to using CONFIG_SCSI_ATA and CONFIG_SCSI_ATA_PIIX 
> for ICH5 SATA support.
> 
Forgot about that...fixed user..;-)

Jurgen


