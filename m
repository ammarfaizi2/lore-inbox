Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSILIEl>; Thu, 12 Sep 2002 04:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSILIEl>; Thu, 12 Sep 2002 04:04:41 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:29678
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S293680AbSILIEl>; Thu, 12 Sep 2002 04:04:41 -0400
Subject: Re: [PATCH] Pull NFS server address off root_server_path
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Schwenke <martin@meltin.net>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <200209120208.MAA00777@thucydides.inspired.net.au>
References: <200209120208.MAA00777@thucydides.inspired.net.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 12 Sep 2002 09:09:37 +0100
Message-Id: <1031818177.2994.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are probably much better using the initrd based dhcp client from
things like the LTSP project (ltsp.org) than the kernel one

