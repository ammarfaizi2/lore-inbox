Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUBCP66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266029AbUBCP65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:58:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60869 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266028AbUBCP64
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:58:56 -0500
Message-ID: <401FC51B.2020607@pobox.com>
Date: Tue, 03 Feb 2004 10:58:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: WHarms@bfs.de
CC: saw@saw.sw.com.sg, linux-kernel@vger.kernel.org
Subject: Re: inux-2.6.1 eepro100: wait_for_cmd_done timeout!
References: <S265923AbUBCIUN/20040203082013Z+179@vger.kernel.org>
In-Reply-To: <S265923AbUBCIUN/20040203082013Z+179@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   (Walter Harms) wrote:
> hi,
> google showd me that this is problem since linux 2.2
> i run a linux 2.6.1 om my ACER tm620 and the driver by Donald Becker.
> 
> My build-in card gets the timeout and after:
>  transmit timed out: status 0050 0cf0 at xxxxx/xxx command 000c0000 it works again (for some time)
> 
> The eepro100 is compiled in.
> 
> should i spend time to find more infos ?


Can you try e100 v3 from Andrew Morton's -mm tree?

	Jeff



