Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbTAJRTv>; Fri, 10 Jan 2003 12:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTAJRTv>; Fri, 10 Jan 2003 12:19:51 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61074
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265587AbTAJRTu>; Fri, 10 Jan 2003 12:19:50 -0500
Subject: Re: BLKBSZSET still not working on 2.4.18 ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: ludovic.drolez@freealter.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200301101708.h0AH8nUS013550@darkstar.example.net>
References: <200301101708.h0AH8nUS013550@darkstar.example.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042222490.32175.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 18:14:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 17:08, John Bradford wrote:
> Didn't some really obscure IBM drives use it for something internally,
> and shortly after everybody else had to stop using it incase they
> overwrote the custom data at the end of an IBM disk, or am I thinking
> of something else?

Something else - EFI uses the last sector for partitioning as one example.
Drives do have protected private areas but they are shielded from normal
use for obvious reasons
