Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264809AbTFBR1e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264810AbTFBR1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:27:34 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:53975 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id S264809AbTFBR1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:27:32 -0400
Date: Mon, 2 Jun 2003 19:40:52 +0200 (CEST)
From: Jody Pearson <J.Pearson@cern.ch>
X-X-Sender: jpearson@lxplus077.cern.ch
To: linux-kernel@vger.kernel.org
Subject: Documentation / code sample wanted.
Message-ID: <Pine.LNX.4.44.0306021939490.31408-100000@lxplus077.cern.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am looking for some source code or a document which outlines how to open 
a TCP connection within kernel space.

After many google searches, and a search of the archives, I cannot seem to 
find an example which says "do this".

There are many references to sk_buff and friends, but nothing more 
practical.

I have looked over khttpd, which has been some help, and I looked briefly 
at the nfs code, but I don't want to use RPC.

Can anybody point me to a document/code/patch to help me out ?

For more information, I basically want to emulate a userland 
gethostbyname() in kernel space.

Thanks

Jody

--
Chaos, Panic, Pandemonium...  my work here is done.


