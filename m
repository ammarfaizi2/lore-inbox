Return-Path: <linux-kernel-owner+w=401wt.eu-S964976AbXAGTbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbXAGTbg (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbXAGTbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:31:36 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:49839 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964976AbXAGTbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:31:35 -0500
Date: Sun, 7 Jan 2007 11:30:57 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] math-emu/setcc: avoid gcc extension
Message-Id: <20070107113057.504f52c2.randy.dunlap@oracle.com>
In-Reply-To: <79c1e7a7bfa499fc896c00a1adb0edeb@kernel.crashing.org>
References: <20070106221947.8e01d404.randy.dunlap@oracle.com>
	<33e707f92df6b89a1c22f337f230cf32@kernel.crashing.org>
	<20070107104555.015aa79f.randy.dunlap@oracle.com>
	<974f8eb0d5984af6726a130082453916@kernel.crashing.org>
	<20070107111900.9d434162.randy.dunlap@oracle.com>
	<79c1e7a7bfa499fc896c00a1adb0edeb@kernel.crashing.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2007 20:29:21 +0100 Segher Boessenkool wrote:

> >> There's an extra tab in that last line.  Could you also
> >> please fix the indenting (use a tab, not spaces) -- I know
> >> it was there originally, but since there are only a few
> >> lines in that file like that...  :-)
> >
> > how's this one?
> 
> I meant fix all the wrongly indented lines in that file (there
> are only a few, and all around where you're patching anyway).
> 
> Care for one extra time?  :-)

Not really.  That should be a different patch IMO.

---
~Randy
