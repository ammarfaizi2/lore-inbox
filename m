Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbWCGD50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbWCGD50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbWCGD50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:57:26 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:12167
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932578AbWCGD5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:57:25 -0500
Date: Mon, 6 Mar 2006 19:56:45 -0800
From: Greg KH <greg@kroah.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Greg KH <gregkh@suse.de>,
       Nicholas Miell <nmiell@comcast.net>, "Theodore Ts'o" <tytso@mit.edu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060307035645.GB23284@kroah.com>
References: <20060227234525.GA21694@suse.de> <20060228063207.GA12502@thunk.org> <20060301003452.GG23716@kroah.com> <1141175870.2989.17.camel@entropy> <20060302042455.GB10464@suse.de> <m1fylwc1c8.fsf@ebiederm.dsl.xmission.com> <20060305232326.GC20768@kvack.org> <m1y7zoa0sf.fsf@ebiederm.dsl.xmission.com> <20060306003933.GE20768@kvack.org> <m1lkvo9v4o.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1lkvo9v4o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 07:15:03PM -0700, Eric W. Biederman wrote:
> 
> So the question is can we get good enough at review that we can live
> with the few mistakes that make it through?

Exactly.

Combined with the fact that we do not have many reviewers (it's a
thankless, grumpy job), makes it very hard to make it "good enough"...

thanks,

greg k-h
