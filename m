Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUDSBAc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 21:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264232AbUDSBAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 21:00:32 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:9992 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264229AbUDSBAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 21:00:31 -0400
Date: Mon, 19 Apr 2004 09:07:29 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Venkata Ravella <Venkata.Ravella@synopsys.com>
cc: linux-kernel@vger.kernel.org,
       Ramki Balasubramanian <Ramki.Balasubramanium@synopsys.com>,
       ab@californiadigital.com, hpa@zytor.com
Subject: Re: Automount/NFS issues causing executables to appear corrupted
In-Reply-To: <20040418212346.GA23560@rearview.synopsys.com>
Message-ID: <Pine.LNX.4.58.0404190902090.18918@wombat.indigo.net.au>
References: <20040418212346.GA23560@rearview.synopsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please cc autofs questions to the list at autofs@linux.kernel.org.

On Sun, 18 Apr 2004, Venkata Ravella wrote:

> 
> The current kernel we use is default 7.2 kernel with two modifications:
> 1) BM patch applied to extend address space for a single process to 3.6GB
> 2) mnt patch applied to allow upto 1024 nfs mount points
> 
> uname -r output:
> 2.4.7-10mntBMsmp

What autofs version?

To be honest it's a bit hard to see how this is an autofs issue.
Mind, having said that, ....

Ian

