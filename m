Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTFTUNn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 16:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTFTUNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 16:13:43 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:15926 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264601AbTFTUNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 16:13:41 -0400
Message-ID: <3EF36E2C.3050906@myrealbox.com>
Date: Fri, 20 Jun 2003 16:27:24 -0400
From: Nicholas Wourms <nwourms@myrealbox.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 MultiZilla/v1.1.20
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org, jmorris@intercode.com.au, davem@redhat.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Breaking data compatibility with userspace bz2lib
References: <20030620185915.GD28711@wohnheim.fh-wedel.de> <20030620190957.GA19988@gtf.org>
X-Enigmail-Version: 0.75.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Fri, Jun 20, 2003 at 08:59:15PM +0200, J?rn Engel wrote:
> The big question is whether the bzip2 better compression is actually
> useful in a kernel context?  Patches to do bzip2 for initrd, for
> example, have been around for ages:
> 
> 	http://gtf.org/garzik/kernel/files/initrd-bzip2-2.2.13-2.patch.gz
> 

Not to mention the more current ongoing work by Christian Ludwig for 
2.4.2x support at:

http://shepard.kicks-ass.net/~cc/

Cheers,
Nicholas

