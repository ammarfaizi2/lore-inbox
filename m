Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264554AbTFAMUy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 08:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTFAMUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 08:20:53 -0400
Received: from public1-brig1-3-cust85.brig.broadband.ntl.com ([80.0.159.85]:20489
	"EHLO reg_kipling.kenmoffat.uklinux.net") by vger.kernel.org
	with ESMTP id S264554AbTFAMUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 08:20:53 -0400
Date: Sun, 1 Jun 2003 13:34:13 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
X-X-Sender: ken@reg_kipling
To: gcoady@bendigo.net.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 -ac zip ppa --  'mount: /dev/sda4 is not a valid block
 device'
In-Reply-To: <dgdidvo52kn1jhpt3dqsitidql172bbj07@4ax.com>
Message-ID: <Pine.LNX.4.53.0306011331330.30199@reg_kipling>
References: <2j5idv0eh05vpva8tqkd4lc97bbh3dhack@4ax.com>
 <dgdidvo52kn1jhpt3dqsitidql172bbj07@4ax.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jun 2003, Grant wrote:

> Hi there,
>
> A followup: kernel 2.4.21-rc6-ac1 also fails to recognise
> the zip ppa /dev/sda4 as a block device.
>
> Cheers,
> Grant.
>

 Maybe a stupid question, but I'm assuming you have this as a module.
Have you loaded the module before trying to access the device ?

Ken
-- 
Live Long or Prosper! No, wait, that wasn't it...
