Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268989AbTBWXK1>; Sun, 23 Feb 2003 18:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268990AbTBWXK0>; Sun, 23 Feb 2003 18:10:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44416
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268989AbTBWXK0>; Sun, 23 Feb 2003 18:10:26 -0500
Subject: Re: Question about Linux signal handling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Albert Cahalan <albert@users.sourceforge.net>, developer_linux@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1046041491.31809.46.camel@cube>
References: <1046039341.32116.34.camel@cube>
	 <1046043810.2092.0.camel@irongate.swansea.linux.org.uk>
	 <1046041491.31809.46.camel@cube>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046046030.2210.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 24 Feb 2003 00:20:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-23 at 23:04, Albert Cahalan wrote:
> > Firstly BSD didn't get it wrong, things merely diverged
> > historically after V7 unix.
> 
> BSD is wrong for not choosing a different name
> for the new system call and leaving the old one.

The same is true of System 5. Both of the changes semantics
from V7 unix.

> > glibc has the best of both worlds
> 
> Non-default behavior is nearly irrelevant. The default
> should have matched traditional UNIX and Linux behavior.

Its all in the docs, and to quote one of the smarter managerial
people we had in Red Hat "I can only provide the information, I 
can't make you hear it."

Alan

