Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTHFOMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTHFOMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:12:53 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:50952 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262577AbTHFOMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:12:52 -0400
Date: Wed, 6 Aug 2003 10:12:50 -0400
From: Havoc Pennington <hp@redhat.com>
To: rhl-devel-list@redhat.com
Cc: linux-kernel@vger.kernel.org, Antonio Vargas <wind@cocodriloo.com>
Subject: Re: My report on running 2.6.0-test2 on a Dell Inspiron 7000 (possible tty trouble)
Message-ID: <20030806101250.K17064@devserv.devel.redhat.com>
References: <20030806021621.2da5a850.dickson@permanentmail.com> <20030806022256.4b4f967c.dickson@permanentmail.com> <20030806114234.GD814@wind.cocodriloo.com> <20030806060939.1b2a1521.dickson@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030806060939.1b2a1521.dickson@permanentmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 06:09:39AM -0700, Paul Dickson wrote:
> On Wed, 6 Aug 2003 13:42:34 +0200, Antonio Vargas wrote:
> > This is a bug in gnome-terminal:
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=89151
> > 
> 
> This bug is still in the gnome-terminal version included with Severn.
> 

Terminal emulation is vte, gnome-terminal is just the menubar and
prefs dialog. I moved the bug now (it probably would have been closed
already if Nalin had seen it, sorry about that).

Havoc
