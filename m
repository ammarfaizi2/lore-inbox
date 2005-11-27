Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbVK0JW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVK0JW2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 04:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbVK0JW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 04:22:28 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:30645 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750959AbVK0JW1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 04:22:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kgw19BUaoUC2LBahsV3FgYE971aSIUW6EdtMhk3HMpuUihXnC3u+goKAv7sxYHHgnTU8ZxW3DL/ToOmubxwcY5yEpIGeoXO9Qt1KRKUZj9pZ4Eks5VGpqJhbBxNOqNrEliaOjmvjgGVuqwOopYwe5hgLtkTIHhVWLHK0MNUg6fk=
Message-ID: <9c21eeae0511270122h38cfb4a4y5d242347cbf9a21e@mail.gmail.com>
Date: Sun, 27 Nov 2005 01:22:26 -0800
From: David Brown <dmlb2000@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051127060937.GN11266@alpha.home.local>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It certainly is not an excuse, but at least it my explain why nobody
> noticed it before you :-)

Thanks for the info and suggestions ;)
I trust Linus enough to compile a kernel as root... but maybe that's just me ;)
(or maybe I trust that I can fix anything that can fsck up my system
even with root perms ;))

I agree compiling the kernel as a non-root user is perfered but
sometimes it doesn't happen that way...

- David Brown
