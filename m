Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbSKUTw5>; Thu, 21 Nov 2002 14:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSKUTw4>; Thu, 21 Nov 2002 14:52:56 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:9352 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264815AbSKUTwb>; Thu, 21 Nov 2002 14:52:31 -0500
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kent Borg <kentborg@borg.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021121140510.N16336@borg.org>
References: <20021121125240.K16336@borg.org> <3DDD24E7.4040603@pobox.com>
	<20021121133922.M16336@borg.org>
	<1037906458.7660.74.camel@irongate.swansea.linux.org.uk> 
	<20021121140510.N16336@borg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Nov 2002 20:28:34 +0000
Message-Id: <1037910514.7687.80.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-21 at 19:05, Kent Borg wrote:
> Another example of why this needs to be done in the file system.  (And
> that help is sometimes needed from the "disk" particularly in cases
> like flash IDE rives.)

The file system can't do it
The flash device won't give you the info to do it
The ide disk wont give you the info to do it

Its possibly a polite hint from the universe to use encryption 8)

