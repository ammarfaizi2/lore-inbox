Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268807AbUIMPxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268807AbUIMPxP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268565AbUIMPpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:45:39 -0400
Received: from ida.rowland.org ([192.131.102.52]:20228 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S268844AbUIMPl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:41:57 -0400
Date: Mon, 13 Sep 2004 11:41:50 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Randy Dunlap <rddunlap@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: How to find out which kernel release contains some code
Message-ID: <Pine.LNX.4.44L0.0409131132570.3202-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy:

Is there any simple easy way to find out in which kernel release a 
particular line of code first appeared?  Or to find out whether that line 
is or isn't present in a particular release?

The timestamps in BitKeeper don't help much.  They seem to reflect the 
first time the code was put into _any_ BitKeeper repository, not the time 
it was entered into Linus's tree.  The web interface to the linux-2.6 tree 
doesn't offer any way to view a particular source file as of a particular 
release tag.

I don't fancy downloading lots and lots of enormous patch files, searching
for one small entry.  Or lots of kernel source tarballs, for that matter.

There's got to be an easier way.  Do you know of one?

Alan Stern

