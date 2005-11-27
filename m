Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVK0QaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVK0QaT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 11:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVK0QaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 11:30:19 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:8810 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751107AbVK0QaR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 11:30:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B5Y5/2CRwaYw/KogRttmulsEZs47KWnrVVgfSnz9wQDl8B5QrG3zUjYW8nEz7Fqhx+22rm+oLuXyzxT4ribGju+Nf07ME8pb7BzJe7S4mSh3+fmPyabfn4gQQH+ye0czeT5aqAdQGPhvPH9JG5vFARJ+ZWS/4jWiY8MmtJyTDGs=
Message-ID: <9a8748490511270830m4bf88fd7v2617f4d2280cc10e@mail.gmail.com>
Date: Sun, 27 Nov 2005 17:30:15 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: David Brown <dmlb2000@gmail.com>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Cc: Willy Tarreau <willy@w.ods.org>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <9c21eeae0511270122h38cfb4a4y5d242347cbf9a21e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
	 <200511270138.25769.s0348365@sms.ed.ac.uk>
	 <29495f1d0511261746y12a0c356ueb3d5bb08aa6f6a@mail.gmail.com>
	 <200511270151.21632.s0348365@sms.ed.ac.uk>
	 <9c21eeae0511261756r65d0f4b7l96b0e1089c4c62bc@mail.gmail.com>
	 <29495f1d0511261827s7984bea8l92149b8a3091e6d8@mail.gmail.com>
	 <9c21eeae0511261838ncec563v1739a1230347365b@mail.gmail.com>
	 <20051127060937.GN11266@alpha.home.local>
	 <9c21eeae0511270122h38cfb4a4y5d242347cbf9a21e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/05, David Brown <dmlb2000@gmail.com> wrote:
> > It certainly is not an excuse, but at least it my explain why nobody
> > noticed it before you :-)
>
> Thanks for the info and suggestions ;)
> I trust Linus enough to compile a kernel as root... but maybe that's just me ;)

Well, Linus makes mistakes like everyone else. Besides, he himself
also recommends that people build kernels as non-root :

"I would suggest that people who compile new kernels should:
...
 - compile the kernel in their own home directory, as their very own
   selves. No need to be root to compile the kernel. You need to be root
   to _install_ the kernel, but that's different. "

see http://uwsg.iu.edu/hypermail/linux/kernel/0007.3/0587.html for the
source of that quote.


> (or maybe I trust that I can fix anything that can fsck up my system
> even with root perms ;))
>
> I agree compiling the kernel as a non-root user is perfered but
> sometimes it doesn't happen that way...
>
> - David Brown


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
