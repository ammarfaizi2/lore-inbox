Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTJGUrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 16:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbTJGUrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 16:47:48 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:41232 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S262865AbTJGUrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 16:47:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: devfs and udev
Date: Tue, 7 Oct 2003 23:47:41 +0300
X-Mailer: KMail [version 1.4]
Cc: =?iso-8859-1?q?M=E5ns=20Rullg=E5rd?= <mru@users.sourceforge.net>
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com> <200310072128.09666.insecure@mail.od.ua> <20031007194124.GA2670@kroah.com>
In-Reply-To: <20031007194124.GA2670@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200310072347.41749.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 October 2003 22:41, Greg KH wrote:
> On Tue, Oct 07, 2003 at 09:28:09PM +0300, insecure wrote:
> > What am I supposed to do, starting to use mknod again? Uggggh...
>
> Provide me with a kernel name to devfs name mapping file so that I can
> create a "devfs like" udev config file for people who happen to like
> that naming scheme.

It seems that we have a bit of misunderstanding here.

I just don't want to go back to /dev being actually placed on
real, on-disk fs.

I won't mind if naming scheme will change as long
as device names start with '/dev/' and appear
there (semi-)automagically. That's what I call devfs.
If udev can do this, I am all for that.
-- 
vda
