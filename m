Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTCCPLb>; Mon, 3 Mar 2003 10:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbTCCPLb>; Mon, 3 Mar 2003 10:11:31 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42139
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265339AbTCCPLa>; Mon, 3 Mar 2003 10:11:30 -0500
Subject: Re: 2.4 iget5_locked port attempt to 2.4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Drokin <green@namesys.com>
Cc: Andrew Morton <akpm@digeo.com>, mason@suse.com, trond.myklebust@fys.uio.no,
       jaharkes@cs.cmu.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030303170924.B3371@namesys.com>
References: <20030220175309.A23616@namesys.com>
	 <20030220154924.7171cbd7.akpm@digeo.com> <20030221220341.A9325@namesys.com>
	 <20030221200440.GA23699@delft.aura.cs.cmu.edu>
	 <20030303170924.B3371@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046708741.6509.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 16:25:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 14:09, Oleg Drokin wrote:
> Hello!
> 
>    It's me again, I basically got no reply for this iget5_locked patch
>    I have now. Would there be any objections if I try push it to Marcelo
>    tomorrow? ;)

I just binned it. Certainly its not the kind of stuff I want to test in -ac, 
too many VFS changes outside reiserfs

