Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263635AbTDTRJM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 13:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTDTRJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 13:09:12 -0400
Received: from mail.ithnet.com ([217.64.64.8]:15890 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263635AbTDTRJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 13:09:11 -0400
Date: Sun, 20 Apr 2003 19:21:10 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: John Bradford <john@grabjohn.com>
Cc: john@grabjohn.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030420192110.1a457c2d.skraw@ithnet.com>
In-Reply-To: <200304201712.h3KHCsBu000709@81-2-122-30.bradfords.org.uk>
References: <20030420185512.763df745.skraw@ithnet.com>
	<200304201712.h3KHCsBu000709@81-2-122-30.bradfords.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003 18:12:54 +0100 (BST)
John Bradford <john@grabjohn.com> wrote:

> > Can you tell me what is so particularly bad about the idea to cope a
> > little bit with braindead (or just-dying) hardware?
> 
> Nothing - what is wrong is to implement it in a filesystem, where it
> does not belong.

I know you favor a layer between low-level driver and fs probably. Sure it is
clean design, and sure it sounds like overhead (Yet Another Layer).

> > See, a car (to name a real good example) is not primarily built to have
> > accidents.
> 
> Stunt cars are built to survive accidents.  All cars _could_ be built
> like stunt cars, but they aren't.

Well, I do really hope that my BMW is built to survive accidents, too. Because
if it is not, I go and buy a Mercedes immediately. We are looking for passive
safety stuff here, and if it _can_ make a difference to spend one buck more,
then I will do ...

Regards,
Stephan

