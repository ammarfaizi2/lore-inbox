Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbUDRDRP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 23:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbUDRDRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 23:17:15 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:951 "EHLO work.bitmover.com")
	by vger.kernel.org with ESMTP id S264103AbUDRDRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 23:17:14 -0400
Date: Sat, 17 Apr 2004 20:17:13 -0700
From: Larry McVoy <lm@bitmover.com>
Message-Id: <200404180317.i3I3HD3x013445@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: NFS exporting imports?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Long ago I remember that Linux had an unusual feature wherein you could
export /home and on the NFS server you could import something and it 
would be exported.  It was different than other NFS servers and this was
so long ago it may very well have been the user level NFS server code that
did this (in fact, I'll bet it was, it makes sense).

Regardless, I've finally hit a situation where that would be a nice feature
and I was wondering if there was some way to make the current (2.4) NFS
code do the same thing.

And while I'm here, is anyone maintaining the user level NFS server?  Or
has anyone made it work on a recent kernel?  

--lm
