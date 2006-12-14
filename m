Return-Path: <linux-kernel-owner+w=401wt.eu-S932730AbWLNNqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbWLNNqn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbWLNNqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:46:43 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:40306 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932730AbWLNNqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:46:42 -0500
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
	for 2.6.19]
From: Ben Collins <ben.collins@ubuntu.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
	 <20061214005532.GA12790@suse.de>
	 <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 14 Dec 2006 08:46:15 -0500
Message-Id: <1166103975.6748.190.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So go get it merged in the Ubuntu, (Open)SuSE and RHEL and Fedora trees 
> first. This is not something where we use my tree as a way to get it to 
> other trees. This is something where the push had better come from the 
> other direction.

I can probably speak for Ubuntu in saying we wont include any sort of
patch like this unless it's forced on us.

I have to agree with your your whole statement. The gradual changes to
lock down kernel modules to a particular license(s) tends to mirror the
slow lock down of content (music/movies) that people complain about so
loudly. It's basically becoming DRM for code.

I don't think anyone ever expected technical mechanisms to be developed
to enforce the GPL. It's sort of counter intuitive to why the GPL
exists, which is to free the code.

Let the licenses and lawyers fight to protect the code. The code doesn't
need to do that itself. It's got better things to do.
