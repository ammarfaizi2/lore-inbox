Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265384AbUBIUc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 15:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265385AbUBIUc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 15:32:28 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:59912 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265384AbUBIUc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 15:32:27 -0500
Date: Mon, 9 Feb 2004 21:32:24 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Does anyone still care about BSD ptys?
Message-ID: <20040209213224.A1125@pclin040.win.tue.nl>
References: <1076334541.27234.140.camel@cube> <4027BFE7.5040100@zytor.com> <1076347137.27234.166.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1076347137.27234.166.camel@cube>; from albert@users.sf.net on Mon, Feb 09, 2004 at 12:18:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 12:18:57PM -0500, Albert Cahalan wrote:

> I should mention here that the SysV pty stuff
> is nearly 100% undocumented in the man pages.
> I get nothing for pts, pty, grantpt...

% man pts
NAME
       ptmx and pts - pseudo-terminal master and slave

% man grantpt
NAME
       grantpt - grant access to the slave pseudotty

% man posix_openpt
NAME
       posix_openpt - open a pseudo-terminal device


I have to conclude that your version of "the man pages"
is older than man-pages-1.55. Current is man-pages-1.66.

Andries
