Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTERMw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 08:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbTERMw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 08:52:58 -0400
Received: from smtp.terra.es ([213.4.129.129]:1196 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id S262038AbTERMw4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 08:52:56 -0400
Date: Sun, 18 May 2003 15:05:47 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm6
Message-Id: <20030518150547.2c2049ba.diegocg@teleline.es>
In-Reply-To: <20030518113634.GA3446@hh.idb.hist.no>
References: <20030516015407.2768b570.akpm@digeo.com>
	<20030518000644.74e8e3e8.diegocg@teleline.es>
	<20030518113634.GA3446@hh.idb.hist.no>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003 13:36:34 +0200
Helge Hafting <helgehaf@aitel.hist.no> wrote:

> On Sun, May 18, 2003 at 12:06:44AM +0200, Diego Calleja García wrote:
> > I had this oops don't know how it happened (not reproduceable):
> > 
> <...>
> I also had a 2.5.69-mm6 freeze.  No dump since it happened
> while running X, and no disk activity were possible afterwards.
> No emergency sync, just the sysrq+B.
> This was UP with preempt.


BTW, this was compiled with gcc-3.3 (yeah...i know everybody loves 2.95,
but.... :)
