Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272387AbTHKIpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 04:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272441AbTHKIpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 04:45:55 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:10406 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272387AbTHKIpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 04:45:54 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 11 Aug 2003 10:45:52 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: war <war@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic (NFS, 2.4.2[0-1])
Message-Id: <20030811104552.4e8972be.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.56.0308101710110.10609@p500>
References: <Pine.LNX.4.56.0308101710110.10609@p500>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Aug 2003 17:16:11 -0400 (EDT)
war <war@lucidpixels.com> wrote:

> >From /etc/fstab:
> p500:/d1/x       /p500/x          nfs         rw,hard,intr,rsize=65536,wsize=65536,nfsvers=3 0 0
> 
> A small for loop in bash causes 2.4.20 to panic, and 2.4.21 to have
> massive network packet loss.

What filesystem are you using?

Regards,
Stephan

