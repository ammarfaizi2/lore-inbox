Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbTIJQAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbTIJQAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:00:40 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:4239 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265108AbTIJQAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:00:39 -0400
Subject: Re: Efficient IPC mechanism on Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <04aa01c377a3$4e3cfc20$5aaf7450@wssupremo>
References: <00f201c376f8$231d5e00$beae7450@wssupremo>
	 <20030909175821.GL16080@Synopsys.COM>
	 <001d01c37703$8edc10e0$36af7450@wssupremo>
	 <20030910064508.GA25795@Synopsys.COM>
	 <015601c3777c$8c63b2e0$5aaf7450@wssupremo>
	 <1063185795.5021.4.camel@laptop.fenrus.com>
	 <01c601c3777f$97c92680$5aaf7450@wssupremo>
	 <1063198060.32726.32.camel@dhcp23.swansea.linux.org.uk>
	 <04aa01c377a3$4e3cfc20$5aaf7450@wssupremo>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063209568.32726.84.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Wed, 10 Sep 2003 16:59:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-10 at 14:56, Luca Veraldi wrote:
> There are kernel locks all around in sources.
> So don't come here and talk about locking ineffiency.
> Because scarse scalability of Linux on multiprocessor
> is a reality nobody can hide.

Well if you will read the 2.2 code sure. If you want to argue
scalability I suggest you look at current code and the SGI Altix
boxes

