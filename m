Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbTLET4P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTLET4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:56:14 -0500
Received: from slider.rack66.net ([212.3.252.135]:21921 "EHLO
	slider.rack66.net") by vger.kernel.org with ESMTP id S264369AbTLET4J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:56:09 -0500
Date: Fri, 5 Dec 2003 20:56:09 +0100
From: "'Filip Van Raemdonck'" <filipvr@xs4all.be>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031205195609.GA30309@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031205181222.GA24882@debian> <002101c3bb5e$e36394e0$ca41cb3f@amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002101c3bb5e$e36394e0$ca41cb3f@amer.cisco.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 10:37:51AM -0800, Hua Zhong wrote:
> > Nope, they #include Linux header files - at least in their 
> > Linux version. 
> 
> So what? By the same argument they are derived work of Linux too.
> 
> This is exactly the flaw of "once you include my code, you are derived
> work of mine".

I'll rephrase what I wrote and what people have been saying all the time:

"Once you build a binary module, it contains our (inlined) code and thus
 the binary module is a derived work."

> > And we're not even talking about source code; we're talking about
> > _binary modules_. Which do include object code which comes from GPLed
> > (inline) code; and are thus derived works.
> 
> I disagree. 
> 
> It all depends on how significant the inlined code is compared to the
> whole work of the module. For inline functions, I don't see why using
> them would be a significant part - by definition "inline" means
> "small/trivial", otherwise you would not have inlined them.
> 
> Otherwise, since SCO found a few lines of code copied from Unix in Linux
> source, are we saying the whole million lines of code is derived from
> Unix?

We have yet to see if they actually found code.

And no; we're not saying all code is a derived work. We're saying that if
there is a few lines of copied code, then the compiled kernel which
contains object code coming from these lines is a derived work. If.


Regards,

Filip

-- 
<rcw> debian comes in behind redhat, slackware, suse, and mandrake when
      searching google for 'linux distribution'
<asuffield> try "best linux distribution"
