Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRA2AkD>; Sun, 28 Jan 2001 19:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135189AbRA2Ajy>; Sun, 28 Jan 2001 19:39:54 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:63818 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129631AbRA2Ajg>; Sun, 28 Jan 2001 19:39:36 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: SR 2000 (c) <admin@gamecoding.cjb.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: problem exporting symbols from a lkm 
In-Reply-To: Your message of "Sun, 28 Jan 2001 19:16:06 BST."
             <SAK.2001.01.28.calrnhkd@ahem> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Jan 2001 11:12:42 +1100
Message-ID: <11584.980727162@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001 19:16:06 +0100, 
SR (c) 2000 <admin@gamecoding.cjb.net> wrote:
>my /proc/ksyms shows that the exported symbols from 8390.o are different
>from the other symbols because they have  "_R__ver_" in front of them.

FAQ http://www.tux.org/lkml/#s8-8

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
