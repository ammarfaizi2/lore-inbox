Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVI2TXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVI2TXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVI2TXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:23:33 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:25571 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932375AbVI2TXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:23:32 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <433C3F11.3050408@s5r6.in-berlin.de>
Date: Thu, 29 Sep 2005 21:22:57 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: SCSI Mailing List <linux-scsi@vger.kernel.org>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com>
In-Reply-To: <4339BFE9.1060604@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.485) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> * Avoids (rather than fix) several SCSI core false dependencies on HCIL. 

BTW, other SCSI transport layers in Linux do this too, and have been 
doing so for some time. So this is hardly a valid reason not to include 
the new SAS layer.
-- 
Stefan Richter
-=====-=-=-= =--= ===-=
http://arcgraph.de/sr/
