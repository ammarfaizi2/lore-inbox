Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277147AbRJDHcx>; Thu, 4 Oct 2001 03:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277149AbRJDHcn>; Thu, 4 Oct 2001 03:32:43 -0400
Received: from foobar.isg.de ([62.96.243.63]:36272 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S277147AbRJDHcX>;
	Thu, 4 Oct 2001 03:32:23 -0400
Message-ID: <3BBC10A2.D8283D88@isg.de>
Date: Thu, 04 Oct 2001 09:32:50 +0200
From: Constantin Loizides <Constantin.Loizides@isg.de>
Organization: Innovative Software AG
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>
Cc: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: [POT] Which journalised filesystem uses Linus Torvalds ?
In-Reply-To: <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Sebastien,


> In terms of intergration into the kernel, functionnalities,
> stability and performance which one is the best for entreprise class
> servers
 
You might want to take a look at

http://www.informatik.uni-frankfurt.de/~loizides/reiserfs/

where I try to answer the one of your criteria, namely performance,
and how performance behaves over time, eg. when the file system
is heavily used...


The focus is on ReiserFS compared to Ext2, though I plan to set up
some tests with XFS and JFS soon (to get the results before end
of october)



Constantin
