Return-Path: <linux-kernel-owner+w=401wt.eu-S1751672AbWLNRtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWLNRtb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbWLNRtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:49:31 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:53657 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbWLNRta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:49:30 -0500
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
	for 2.6.19]
From: Ben Collins <ben.collins@ubuntu.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612141821250.12730@yvahk01.tjqt.qr>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
	 <20061214005532.GA12790@suse.de>
	 <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
	 <1166103975.6748.190.camel@gullible>
	 <Pine.LNX.4.61.0612141821250.12730@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 14 Dec 2006 12:49:14 -0500
Message-Id: <1166118554.6748.284.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 18:21 +0100, Jan Engelhardt wrote:
> On Dec 14 2006 08:46, Ben Collins wrote:
> >I have to agree with your your whole statement. The gradual changes to
> >lock down kernel modules to a particular license(s) tends to mirror the
> >slow lock down of content (music/movies) that people complain about so
> >loudly. It's basically becoming DRM for code.
> >
> >I don't think anyone ever expected technical mechanisms to be developed
> >to enforce the GPL. It's sort of counter intuitive to why the GPL
> >exists, which is to free the code.
> 
> """To protect your rights, we need to make restrictions that forbid
> anyone to deny you these rights"""
> 
> >Let the licenses and lawyers fight to protect the code. The code doesn't
> >need to do that itself. It's got better things to do.

And these restrictions are in the letter of the GPL, not the function
prototypes of my code. Anyone willing to write libgpl-enforcement?

I don't care if someone wants to take my code and blatantly make use of
it in their own projects. I encourage it. I wrote it so people could do
whatever the hell they wanted to with it. It's when that project is made
available to others where I expect the GPL to enforce my copyrights and
licenses. I don't expect my code to be self checking for it, and then
add conditions that this portion of the code cannot be removed, because
then it isn't really GPL anymore, because then it isn't really free
either.

Maybe people will be happy if it ends up like this:

Booting Linux...
Please insert your original GNU/Linux source CD...

