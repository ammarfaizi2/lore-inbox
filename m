Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVGLWRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVGLWRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVGLWO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:14:59 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16822
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262458AbVGLWOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:14:48 -0400
Date: Tue, 12 Jul 2005 15:14:38 -0700 (PDT)
Message-Id: <20050712.151438.130617309.davem@davemloft.net>
To: Eric.Moore@lsil.com
Cc: tduffy@sun.com, olh@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 22/82] remove linux/version.h from drivers/message/fus
 ion
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <91888D455306F94EBD4D168954A9457C03157047@nacos172.co.lsil.com>
References: <91888D455306F94EBD4D168954A9457C03157047@nacos172.co.lsil.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
Date: Tue, 12 Jul 2005 14:50:19 -0600

> But Id rather have same files in our maintained driver,
> and whats in the kernel tree.

Just think what a mess we'd have on our hands if we let
everyone do that.  Sorry, please don't put compat header
files into the current upstream tree, thanks.
