Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSJULfQ>; Mon, 21 Oct 2002 07:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbSJULfQ>; Mon, 21 Oct 2002 07:35:16 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:48563 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261322AbSJULfP>; Mon, 21 Oct 2002 07:35:15 -0400
Subject: Re: Crunch time -- Final merge candidates for 3.0 (the list).
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: landley@trommello.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       boissiere@nl.linux.org
In-Reply-To: <200210201849.23667.landley@trommello.org>
References: <200210201849.23667.landley@trommello.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 12:56:48 +0100
Message-Id: <1035201408.27259.46.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 00:49, Rob Landley wrote:
> o in -ac PCMCIA Zoom video support (Alan Cox) 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.1/0326.html

This is just device driver forward porting from the 2.4 kernel. While
its a rather important and useful feature its impact on the kernel core
is actually nil.

