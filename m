Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282133AbRK1MFW>; Wed, 28 Nov 2001 07:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282131AbRK1MFM>; Wed, 28 Nov 2001 07:05:12 -0500
Received: from [195.66.192.167] ([195.66.192.167]:51468 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S282133AbRK1MFI>; Wed, 28 Nov 2001 07:05:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [PATCH] printk loglevel cleanup (again)
Date: Wed, 28 Nov 2001 14:01:27 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <mailman.1006876204.12313.linux-kernel2news@redhat.com> <200111271758.fARHwmO22631@devserv.devel.redhat.com>
In-Reply-To: <200111271758.fARHwmO22631@devserv.devel.redhat.com>
MIME-Version: 1.0
Message-Id: <01112814012701.00944@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 November 2001 15:58, Pete Zaitcev wrote:
> Linus refused wholesale cleanups in the past. Try to identify
> worst offenders and start from those, and work through component
> maintainers. It's a lot more work, but you have to tough it out.

This patch can be split into individual patches right at any hunk boundary.
I think any interested maintainer can take it and apply relevant parts (or as 
a whole, since their diffs for Linus are most probaly made only from relevant 
kernel subtrees (they won't propagate unwanted modifications))

Anyway, it's only printks.
--
vda
