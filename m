Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTJPLQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 07:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTJPLQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 07:16:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36996 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262844AbTJPLQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 07:16:57 -0400
Message-ID: <3F8E7E1C.4010605@pobox.com>
Date: Thu, 16 Oct 2003 07:16:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test7] b44: NETDEV WATCHDOG: eth0: transmit timed out
References: <200310161253.13548.lkml@kcore.org>
In-Reply-To: <200310161253.13548.lkml@kcore.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Same bug as in 2.4:
> 
> Oct 16 12:29:14 precious kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Oct 16 12:29:14 precious kernel: b44: eth0: transmit timed out, resetting
> 
> after which the interface is useless.
> 
> Can the same patch (by  Pekka Pietikainen) be applied?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106476776914551&w=2


Already sent to Linus and Marcelo.

	Jeff



