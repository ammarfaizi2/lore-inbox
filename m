Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264755AbSLPFTp>; Mon, 16 Dec 2002 00:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbSLPFTp>; Mon, 16 Dec 2002 00:19:45 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62684
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264755AbSLPFTp>; Mon, 16 Dec 2002 00:19:45 -0500
Subject: Re: [PROBLEM]: "make rpm" fails on RH 8.0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tarkan Erimer <tarkane@solmaz.com.tr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212151417.34213.tarkane@solmaz.com.tr>
References: <200212151417.34213.tarkane@solmaz.com.tr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Dec 2002 06:06:54 +0000
Message-Id: <1040018814.11669.217.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-15 at 12:17, Tarkan Erimer wrote:
> 
> Hi,
> 
> I try to make kernel rpms via "make rpm" command but,  it fails to build.
> Because, In RH 8.0, build options of rpm moved to "rpmbuild" command, instead 
> of "rpm" command. I think,some modifications to kernel build process will be 
> required to fix it.

Good point. I'll sort that out

