Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTJ3HeS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 02:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTJ3HeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 02:34:18 -0500
Received: from [213.4.129.129] ([213.4.129.129]:44789 "EHLO tsmtp8.mail.isp")
	by vger.kernel.org with ESMTP id S262225AbTJ3HeJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 02:34:09 -0500
Date: Thu, 30 Oct 2003 08:33:56 +0100
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: andersen@codepoet.org, reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
Message-Id: <20031030083356.35e82eaa.diegocg@teleline.es>
In-Reply-To: <20031030015212.GD8689@thunk.org>
References: <3F9F7F66.9060008@namesys.com>
	<20031029224230.GA32463@codepoet.org>
	<20031030015212.GD8689@thunk.org>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 29 Oct 2003 20:52:12 -0500 Theodore Ts'o <tytso@mit.edu> escribió:

> At some level what they have done can be very easily replicated by
> having a userspace database which is tied to the filesystem so you can
> do select statements to search on metadata assocated with files.  We
> can do this simply by associating UUID's to files, and storing the
> file metadata in a MySQL database which can be searched via
> appropriate userspace libraries which we provide.


Something like this?: http://www.gnome.org/~seth/storage/index.html

Another thing that Longhorn *is* doing right is the revamp of the "graphic
subsystem" aka Avalon, they seem to be trying to catch up with Mac OS X
in that field. 
