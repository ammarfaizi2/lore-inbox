Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTESXHD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTESXHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:07:02 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46519
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263375AbTESXFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:05:38 -0400
Subject: Re: Recent changes to sysctl.h breaks glibc
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EC95B58.7080807@zytor.com>
References: <20030519165623.GA983@mars.ravnborg.org>
	 <Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>
	 <babhik$sbd$1@cesium.transmeta.com> <m1d6ie37i8.fsf@frodo.biederman.org>
	 <3EC95B58.7080807@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053382815.29227.29.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 May 2003 23:20:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-19 at 23:31, H. Peter Anvin wrote:
> What I find truly puzzling is that obviously intelligent people like
> yourself still seem to think that ABIs remain fixed.

Because with a few deep system stuff exceptions they do, although they
certainly extend. Rogue for 0.98.5 still runs on 2.4.21 (although you
may have fun finding libc2.2.2)

