Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbTJULNK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 07:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbTJULNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 07:13:10 -0400
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:1682 "EHLO
	water-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S262944AbTJULNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 07:13:08 -0400
Date: Tue, 21 Oct 2003 04:13:05 -0700 (PDT)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@clyde
To: Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Make LLC2 compile with PROC_FS=n
In-Reply-To: <20031020223237.31854ab5.davem@redhat.com>
Message-ID: <Pine.GSO.4.58.0310210401470.26573@clyde>
References: <Pine.GSO.4.58.0310171452540.13905@blinky>
 <20031020101607.76e02647.shemminger@osdl.org> <20031020223237.31854ab5.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Oct 2003, David S. Miller wrote:

> On Mon, 20 Oct 2003 10:16:07 -0700
> Stephen Hemminger <shemminger@osdl.org> wrote:
>
> > Why make up a whole separate llc_proc.h file for two prototypes?
> > Put them on the end of llc.h
>
> I definitely prefer this version of the fix.

I agree completely.  Thanks, Stephen.

> Since Arnaldo appears to be busy, I'll apply this.

Great.

