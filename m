Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263012AbTCVQSw>; Sat, 22 Mar 2003 11:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263319AbTCVQSw>; Sat, 22 Mar 2003 11:18:52 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59546
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263012AbTCVQSv>; Sat, 22 Mar 2003 11:18:51 -0500
Subject: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030322162502.GA870@brodo.de>
References: <20030322140337.GA1193@brodo.de>
	 <1048350905.9219.1.camel@irongate.swansea.linux.org.uk>
	 <20030322162502.GA870@brodo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048354921.9221.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 17:42:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 16:25, Dominik Brodowski wrote:
> > Where is the lock, what does the NMI oopser show ?
> 
> The lock is directly "below" that line -- and the NMI oopser isn't
> triggered, AFAICT

Anything useful off right-alt scroll-lock etc ?

