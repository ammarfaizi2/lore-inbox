Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWBJOIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWBJOIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWBJOIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:08:47 -0500
Received: from thunk.org ([69.25.196.29]:60906 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751247AbWBJOIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:08:47 -0500
Date: Fri, 10 Feb 2006 09:08:42 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Willy Tarreau <willy@w.ods.org>
Cc: Paul Jackson <pj@sgi.com>, jes@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: git for dummies, anyone? (was: Re: How in tarnation do I git v2.6.16-rc2?  hg died and I still don't git git)
Message-ID: <20060210140842.GA18707@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Willy Tarreau <willy@w.ods.org>, Paul Jackson <pj@sgi.com>,
	jes@sgi.com, linux-kernel@vger.kernel.org
References: <20060208070301.1162e8c3.pj@sgi.com> <yq0vevollx4.fsf@jaguar.mkp.net> <20060209065011.45ba1b88.pj@sgi.com> <20060209231650.GF11380@w.ods.org> <20060209160358.5de62d54.pj@sgi.com> <20060210062309.GA22620@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210062309.GA22620@w.ods.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 07:23:09AM +0100, Willy Tarreau wrote:
> I did the opposite : I tried hg as soon as Matt announced it, but I
> got lost in the "python dumps" which appeared at the slightest error,
> because I did not understand what the problem was. Then I tried git,
> at least to be able to keep in sync with Marcelo. With git, I had
> some opportunities to catch some understandable error messages spit
> out of some shell scripts even when not caught by the script itself.
> But using it less than twice a week requires me to read the manual
> again before doing anything useful :-(

Mercurial has gotten a lot better about "python dumps" as a signal
that you had typed something wrong, or had permissions problems, etc.
I got annoyed about that too, but I just learned to ignore them and
assume that 90% of the time, it was due to a mistake on my end.
Things are a lot better there; claiming mercurial sucks for its early
rough edges is about as far as claiming that git sucks because its
performance sucked rocks on laptop drives in its early days before
Linus added support for packs.  

						- Ted
