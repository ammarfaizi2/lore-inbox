Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUF2Q5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUF2Q5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 12:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265813AbUF2Q5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 12:57:12 -0400
Received: from fmx5.freemail.hu ([195.228.242.225]:20009 "HELO
	fmx5.freemail.hu") by vger.kernel.org with SMTP id S265808AbUF2Q5I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 12:57:08 -0400
Date: Tue, 29 Jun 2004 18:57:06 +0200 (CEST)
From: Debi Janos <debi.janos@freemail.hu>
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040629154551.GA6181@outpost.ds9a.nl>
Message-ID: <freemail.20040529185706.6941@fm3.freemail.hu>
X-Originating-IP: [81.182.188.233]
X-HTTP-User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040626 Firefox/0.9.1
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> írta:

> On Tue, Jun 29, 2004 at 03:20:06PM +0200, Debi Janos wrote:
> > I am found an interesting (bug?) feature in kernels between
> > 2.6.7-mm1 and 2.6.7-mm4
> 
> Without further looking at it, try checking if ECN is
turned on.
> /proc/sys/net/ipv4/tcp_ecn if memory serves me well.

Hi!

Thanks. I have tried, but still have problem.

Another site which not working:

http://packages.gentoo.org/
