Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267176AbUH1P0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUH1P0s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 11:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUH1PYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 11:24:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:8864 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267176AbUH1PWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 11:22:21 -0400
Date: Sat, 28 Aug 2004 08:11:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: adam@yggdrasil.com, steve@steve-parker.org, linux-kernel@vger.kernel.org
Subject: Re: PWC issue
Message-Id: <20040828081100.6b6c9f8c.rddunlap@osdl.org>
In-Reply-To: <20040828051919.GC10151@kroah.com>
References: <200408281750.i7SHo5C05936@freya.yggdrasil.com>
	<20040828051919.GC10151@kroah.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 22:19:19 -0700 Greg KH wrote:

| On Sat, Aug 28, 2004 at 10:50:05AM -0700, Adam J. Richter wrote:
| > 
| > 	By the way, I have a long running dispute with Greg K-H
| > about his refusal so far to remove replace the GPL incompatible
| > firmware in certain USB serial drivers with such a user level
| > loading mechanism.  Go figure.
| 
| Send me a patch to do so, and I will apply it (must include userspace
| files so that hotplug can load them properly.)
| 
| The last time we went around about this I rejected it as we were in a
| stable kernel series.  As that is now not true, I'm open to the patch.

Which part is now not true?

| It's not an idealogical issue for me, given Linus's statements about
| firmware in the kernel, but I do agree that it is a better thing as we
| have used up less kernel memory.


--
~Randy
