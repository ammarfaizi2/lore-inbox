Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132241AbRAGNwJ>; Sun, 7 Jan 2001 08:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132370AbRAGNv7>; Sun, 7 Jan 2001 08:51:59 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:10631 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S132369AbRAGNvu>; Sun, 7 Jan 2001 08:51:50 -0500
Date: Sun, 7 Jan 2001 14:52:21 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new bug report script
In-Reply-To: <3A587261.5B3B99BE@yahoo.com>
Message-ID: <Pine.LNX.4.30.0101071451390.7104-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Paul Gortmaker wrote:

> BTW, people have a nasty habit of tacking their entire .config file
> onto bug reports to linux-kernel.  Can you mention "grep ^C .config"
> somewhere in there (or have the script do it) since the number of
> config options isn't going to decrease anytime soon...

I'll make the script do this.

Matthias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
