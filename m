Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTKIPnE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 10:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTKIPnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 10:43:04 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:11140 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262564AbTKIPnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 10:43:02 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 9 Nov 2003 07:42:09 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Larry McVoy <lm@bitmover.com>
cc: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <20031109152534.GA24312@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0311090737550.12198-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Nov 2003, Larry McVoy wrote:

> On Sun, Nov 09, 2003 at 07:16:15AM -0800, H. Peter Anvin wrote:
> > That doesn't include anyone who uses the mirrored repository on the
> > main kernel.org machines.  
> 
> Last I checked, kernel.org isn't offering pserver access, just ftp.  If you
> want to take over the CVS access just say the word.

It is faster for me to use rsync on the CVS root locally, and then use the 
local repository instead. Rsync is better than CVS when it comes to syncs.
Cvsps expecially, really wants a local repository when you start playing 
heavily with -g.



- Davide


