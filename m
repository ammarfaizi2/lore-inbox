Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUEaNho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUEaNho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 09:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUEaNft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 09:35:49 -0400
Received: from quechua.inka.de ([193.197.184.2]:45992 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264595AbUEaNfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 09:35:16 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Add watchdog timer to iseries_veth driver
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040531061442.GA28167@zax>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BUmwc-00085b-00@calista.eckenfels.6bone.ka-ip.net>
Date: Mon, 31 May 2004 15:35:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040531061442.GA28167@zax> you wrote:
> +       printk(KERN_WARNING "%s: Tx timeout!  Resetting lp connections: %08x\n",
> +              dev->name, port->pending_lpmask);

isnt the lp confusing here? veth? lpar?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
