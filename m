Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318351AbSHEJlQ>; Mon, 5 Aug 2002 05:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318355AbSHEJlQ>; Mon, 5 Aug 2002 05:41:16 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:22012 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318351AbSHEJlP>; Mon, 5 Aug 2002 05:41:15 -0400
Subject: Re: HFS-Bug in 2.4.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: pil@mailnet.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D4E435B.1EE20956@mailnet.de>
References: <3D4E435B.1EE20956@mailnet.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 12:03:28 +0100
Message-Id: <1028545408.17775.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 10:20, pil@mailnet.de wrote:
> here is my 4th report since about 2.4.8:
> 
> You can reproduce the bug in a few steps if you have a kernel with
> modules support for hfs.

HFS is not maintained. It will probably go away for 2.6 unless someone
becomes its maintainer and fixes it

