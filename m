Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266610AbUBQVKF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266600AbUBQVIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:08:50 -0500
Received: from [212.28.208.94] ([212.28.208.94]:40714 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266610AbUBQVI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:08:27 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: UTF-8 and case-insensitivity
Date: Tue, 17 Feb 2004 22:08:25 +0100
User-Agent: KMail/1.6.1
Cc: tridge@samba.org, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <16433.38038.881005.468116@samba.org> <Pine.LNX.4.58.0402170704210.2154@home.osdl.org> <Pine.LNX.4.58.0402170833110.2154@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402170833110.2154@home.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402172208.25398.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 17.57, Linus Torvalds wrote:
[case-insanesititvity proposal ///]
> See where I'm going? Would this be acceptable to you? Are there any samba 
> people who are knowledgeable about the VFS-layer and have the time/energy 
> to try something like this?

So the same guy that strongly insist that a file is a string of bytes and nothing else,
now thinks it is sane to even think of "case" of a byte. That's impossible unless you
actually DO believe its a bunch of characters.  What is it?

-- robin
