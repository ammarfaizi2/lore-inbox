Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUAOXJC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 18:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbUAOXJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 18:09:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3297 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263702AbUAOXI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 18:08:57 -0500
Date: Thu, 15 Jan 2004 15:01:37 -0800
From: "David S. Miller" <davem@redhat.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       sim@netnation.com
Subject: Re: Linux 2.4.25-pre5
Message-Id: <20040115150137.253b47a2.davem@redhat.com>
In-Reply-To: <20040115231237.GE26401@conectiva.com.br>
References: <Pine.LNX.4.58L.0401151816320.17528@logos.cnet>
	<20040115145519.79beddc3.davem@redhat.com>
	<20040115231237.GE26401@conectiva.com.br>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004 21:12:37 -0200
Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:

> Dave, haven't checked, but perhaps this cures it:
> 
> <marcelo:logos.cnet>:
>   o Cset exclude: rtjohnso@eecs.berkeley.edu|ChangeSet|20040109135735|05388
>   o Fix microcode update compilation error
>   o Fix Makefile typo
>  ^^^^^^^^^^^^^^^^^^^^
>  ^^^^^^^^^^^^^^^^^^^^
>  ^^^^^^^^^^^^^^^^^^^^

Don't think so, current bk://linux.bkbits.net/linux-2.4 that I can see
still has "UBLEVEL" at the beginning of line 3 of linux/Makefile
