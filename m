Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbTDQFeB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263068AbTDQFeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:34:00 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:38800 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP id S263067AbTDQFeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:34:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: Linus Torvalds <torvalds@transmeta.com>, John Bradford <john@grabjohn.com>
Subject: Re: kernel support for non-English user messages
Date: Tue, 15 Apr 2003 11:02:15 -0700
User-Agent: KMail/1.4.3
Cc: vda@port.imtp.ilyichevsk.odessa.ua,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0304141024250.19302-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0304141024250.19302-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304141645.48020.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 April 2003 10:29, Linus Torvalds wrote:
> Personally, I don't write documentation. I don't much even write
> comments in my code. My personal feeling is that as long as
> functions are small and readable (and logical), and global
> variables have good names, that's all I need to do. Others - who do
> care about comments and docs - can do that part.

This is true, even from a software engineering perspective.

If you find yourself having to write comments and documentation to 
explain your code, probably your identifiers are not well named, your 
functions are not short enough, and your code is not well structured 
enough.

Ideal code is completely self-documenting.

Eric


