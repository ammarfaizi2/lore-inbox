Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263485AbSJHWBA>; Tue, 8 Oct 2002 18:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263488AbSJHWA7>; Tue, 8 Oct 2002 18:00:59 -0400
Received: from pc132.utati.net ([216.143.22.132]:7330 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S263486AbSJHWAs>; Tue, 8 Oct 2002 18:00:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0  -  (NUMA))
Date: Tue, 8 Oct 2002 13:06:15 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <E17ydRY-0003uQ-00@starship> <20021008161555.GA2913@think.thunk.org> <3DA33455.4065101E@digeo.com>
In-Reply-To: <3DA33455.4065101E@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021008220613.C2C33544@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 October 2002 03:39 pm, Andrew Morton wrote:

> Well the current Orlov patch will spread top-level directories,
> so as long as /home is a mountpoint, we're fine.
>
> For more generalality, yes, I think a new chattr flag on the
> parent directory which says "spread my subdirectories out"
> would be a good solution.

Individual sysadmins may not use it much, but getting distributions to put it 
in their install/upgrade software isn't too unlikely...

Rob
