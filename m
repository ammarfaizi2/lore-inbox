Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266454AbUBQTAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266452AbUBQTAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:00:19 -0500
Received: from main.gmane.org ([80.91.224.249]:59849 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266454AbUBQTAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:00:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Date: Tue, 17 Feb 2004 20:00:08 +0100
Message-ID: <yw1xr7wtcz0n.fsf@ford.guide>
References: <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org>
 <20040216200321.GB17015@schmorp.de>
 <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org>
 <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de>
 <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217161111.GE8231@schmorp.de>
 <Pine.LNX.4.58.0402170820070.2154@home.osdl.org>
 <20040217164651.GB23499@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-95a870d5.037-69-73746f23.cust.bredbandsbolaget.se
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:KS+fKYUbewnBANVWKc/ovmhhTs8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Linus Torvalds wrote:
>> I think the filenames are just ways for a _program_ to look up stuff, and
>> the human readability is a secondary thing (it's "polite", but not a
>> fundamental part of their meaning).
>
> Politeness is nice.  I'm sure there's a pragmatic reason most
> filenames are meaningful text in some human language :)
>
> I'd like a way to type something like "touch zöe.txt" on an ordinary
> latin1 terminal and get a UTF-8 filename in my filesystem.  Thanks :)

Then hack either bash (or whatever shell you use) or touch to do just that.

-- 
Måns Rullgård
mru@kth.se

