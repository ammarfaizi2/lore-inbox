Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267771AbTGHWm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267852AbTGHWm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:42:57 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:45323 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267771AbTGHWmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:42:37 -0400
Date: Tue, 8 Jul 2003 23:57:11 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Joshua Kwan <joshk@triplehelix.org>
cc: Ben Collins <bcollins@debian.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New fbdev updates.
In-Reply-To: <20030704085303.GB26432@triplehelix.org>
Message-ID: <Pine.LNX.4.44.0307082346460.32323-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jul 2003, Joshua Kwan wrote:

> On Thu, Jul 03, 2003 at 07:50:39PM -0400, Ben Collins wrote:
> > Seems my old corrupt cursor is fixed, but with your new code I am
> > getting ghost cursors left behind while moving around in vim over ssh
> > with syntax on.
> 
> I am noticing too, but this is local. In fact I am seeing a bunch of
> ghost cursors as I edit this message :)

Fixed one problem but I have a few more to go :-( The soft cursor isn't 
deleteing itself after it moves.


