Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUGJIe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUGJIe7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 04:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUGJIe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 04:34:59 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:50595 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266195AbUGJIe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 04:34:58 -0400
Date: Sat, 10 Jul 2004 09:33:47 +0100
From: Dave Jones <davej@redhat.com>
To: Hans Reiser <reiser@namesys.com>
Cc: jmerkey@comcast.net, Pete Harlan <harlan@artselect.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Message-ID: <20040710083347.GC6386@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Hans Reiser <reiser@namesys.com>, jmerkey@comcast.net,
	Pete Harlan <harlan@artselect.com>, linux-kernel@vger.kernel.org
References: <070920041920.2370.40EEEFFD000B341B000009422200763704970A059D0A0306@comcast.net> <40EF797E.6060601@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EF797E.6060601@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 10:07:10PM -0700, Hans Reiser wrote:
 > Don't use it on redhat systems, those bug reports tend to be for redhat 
 > kernels, redhat refuses to apply our bugfixes that we send in to the 
 > official kernel because they want us to look bad.  I sound so paranoid 
 > when I say that, but they really do refuse to apply our bugfixes.

We don't *want* you to look bad, but when you insist on posting
conspiracy theory crap like the above, you bring it on yourself.

FYI, Fedora aggressively tracks mainline. So any of 'your' bugfixes
sent into the official kernel get picked up usually within a day.
RHEL being somewhat more conservative, doesn't, (and reiserfs
is unsupported there anyway).

The *only* times we _refuse_ to apply bugfixes are when said bugfixes
cause more problems than they are alleged to fix, or when those
fixes aren't relevant for some reason, but don't let facts get in
the way of a good rant.

		Dave

