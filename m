Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267858AbUHPScu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267858AbUHPScu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267859AbUHPScu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:32:50 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:46763 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S267858AbUHPSct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:32:49 -0400
Date: Mon, 16 Aug 2004 20:32:47 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: David Ashley <dash@xdr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Possible 2.4.18 ipv4 memory leak?
In-Reply-To: <200408161813.i7GID8ia023528@xdr.com>
Message-ID: <Pine.LNX.4.53.0408162026250.12635@gockel.physik3.uni-rostock.de>
References: <200408161813.i7GID8ia023528@xdr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've tried studying changelogs to no avail.

There seem to be quite a few fixes for memory leaks since 2.4.18,
some network/ethernet related:

http://linux.bkbits.net:8080/linux-2.4/search/?expr=leak&search=ChangeSet+comments

I guess you won't have much luck finding someone to look into your problem 
unless you try with a recent kernel.

Tim
