Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbTLENJm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 08:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbTLENJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 08:09:42 -0500
Received: from 5.86.35.65.cfl.rr.com ([65.35.86.5]:24960 "EHLO
	drunkencodepoets.com") by vger.kernel.org with ESMTP
	id S264106AbTLENJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 08:09:41 -0500
Date: Fri, 5 Dec 2003 08:09:53 -0500
From: Pat Erley <paterley@mail.drunkencodepoets.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-Id: <20031205080953.66ae9cb9.paterley@mail.drunkencodepoets.com>
In-Reply-To: <BAY7-DAV37GkZcFUjvZ0000328a@hotmail.com>
References: <MDEHLPKNGKAHNMBLJOLKKEGMIHAA.davids@webmaster.com>
	<BAY7-DAV37GkZcFUjvZ0000328a@hotmail.com>
Organization: drunkencodepoets.com
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003 21:43:01 -0500
"Jason Kingsland" <Jason_Kingsland@hotmail.com> wrote:

> But in most of the more recent cases the driver/module code is written
> specifically for Linux, so it seems more appropriate that they would be
> considered as derived works of the kernel. But those various comments from
> Linus are being taken out of context to somehow justify permission for the
> non-release of source code for binary loadable modules.
> 
> Linux is not pure GPL, it also has the Linus "user program" preamble in
> copying.txt - that preamble plus other LKML posts from Linus are commonly
> used as justifications for non-disclosure of source code to some classes of
> modules.

what I forsee happening is, if the mandation of modules is enforced, people will start writing modules that just export the module interfaces to userspace and start writing userspace drivers, which will just be slower and uglier than the binary only drivers being sent right now.  I know about these drivers, I use an nforce2 motherboard.  Fortunately, people have reverse engineered the network driver for this (and I do love forcedeth) and people have reverse engineered other drivers, or brute force hacked them.  And I'm guessing people will have to continue to do this until linux becomes common on the desktop.

Pat Erley
