Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbTLNXF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 18:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTLNXF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 18:05:29 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:20880 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262686AbTLNXF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 18:05:26 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org, bitkeeper-users@bitmover.com
Subject: Re: RFC - tarball/patch server in BitKeeper 
In-reply-to: Your message of "Sun, 14 Dec 2003 09:21:56 -0800."
             <20031214172156.GA16554@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Dec 2003 10:05:03 +1100
Message-ID: <2122.1071443103@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Dec 2003 09:21:56 -0800, 
Larry McVoy <lm@bitmover.com> wrote:
>I've prototyped an extension to BitKeeper that provides tarballs
>and patches.  ...
>... You need to understand that this is all you get,
>we're not going to extend this so you can do anything but track the most
>recent sources accurately.  No diffs.  No getting anything but the most
>recent version.  No revision history.  

Do we get the changelogs from each BK check in?  Without the
changelogs, patches are going to be much less useful.

