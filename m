Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289203AbSAIHbj>; Wed, 9 Jan 2002 02:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289205AbSAIHbV>; Wed, 9 Jan 2002 02:31:21 -0500
Received: from daikokuya.demon.co.uk ([158.152.184.26]:20610 "EHLO
	monkey.daikokuya.demon.co.uk") by vger.kernel.org with ESMTP
	id <S289203AbSAIHbD>; Wed, 9 Jan 2002 02:31:03 -0500
Date: Wed, 9 Jan 2002 07:32:38 +0000
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
Message-ID: <20020109073238.GA5475@daikokuya.demon.co.uk>
In-Reply-To: <3C3B664B.3060103@intel.com> <20020108220149.GA15816@kroah.com> <20020108235649.A26154@xs4all.nl> <20020108231147.GA16313@kroah.com> <20020108181202.A986@twiddle.net> <20020109072313.GA18359@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109072313.GA18359@kroah.com>
User-Agent: Mutt/1.3.25i
From: Neil Booth <neil@daikokuya.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:-

> So, if you are going to change this (well, sounds like it is already
> done), what is the timeline from taking a well documented feature and
> breaking it (based on the example in the info page)?  First a warning,
> and then an error, right?  What version of the compiler emits a warning,
> and what future version will emit an error?  I didn't see anything about
> these kinds of changes in the gcc development plan, or am I missing some
> documentation somewhere?

The documentation snippet someone posted said it would be removed in 3.2.
3.0.3 emits the warning, as does 3.1 in CVS.

Neil.
