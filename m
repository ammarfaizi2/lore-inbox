Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUBRNMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbUBRNMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:12:05 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:8101 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S262030AbUBRNMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:12:03 -0500
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
In-Reply-To: <20040217164651.GB23499@mail.shareable.org>
References: <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217161111.GE8231@schmorp.de> <Pine.LNX.4.58.0402170820070.2154@home.osdl.org> <Pine.LNX.4.58.0402170820070.2154@home.osdl.org> <20040217164651.GB23499@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E1AtRUZ-000309-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Wed, 18 Feb 2004 13:11:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>I'd like a way to type something like "touch zöe.txt" on an ordinary
>latin1 terminal and get a UTF-8 filename in my filesystem.  Thanks :)

screen will already do this - check the encoding command. There's a
couple of more lightweight proxies that do much the same thing.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
