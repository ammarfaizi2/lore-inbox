Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285812AbRLTC1R>; Wed, 19 Dec 2001 21:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285813AbRLTC1I>; Wed, 19 Dec 2001 21:27:08 -0500
Received: from tierra.ucsd.edu ([132.239.214.132]:17042 "EHLO burn")
	by vger.kernel.org with ESMTP id <S285812AbRLTC0x>;
	Wed, 19 Dec 2001 21:26:53 -0500
Date: Wed, 19 Dec 2001 18:26:28 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: billh@tierra.ucsd.edu, bcrl@redhat.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011219182628.A13280@burn.ucsd.edu>
In-Reply-To: <20011219135708.A12608@devserv.devel.redhat.com> <20011219.161359.71089731.davem@redhat.com> <20011219171631.A544@burn.ucsd.edu> <20011219.172046.08320763.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011219.172046.08320763.davem@redhat.com>; from davem@redhat.com on Wed, Dec 19, 2001 at 05:20:46PM -0800
From: Bill Huey <billh@tierra.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 05:20:46PM -0800, David S. Miller wrote:
> Precisely, in fact.  Anyone who can say that Java is going to be
> relevant in a few years time, with a straight face, is only kidding
> themselves.

Oh give me coke shooting, Steeley Dan, late 70s bitter kernel
programmer break...

> Java is not something to justify a new kernel feature, that is for
> certain.

Java is here now and used extensively on server side applications.
Simply dismissing it doesn't invalidate the claim that I made before
about how this mentality is outdated.

The economic inertia of Java driven server applications should have
enough force that it is justifyable to RedHat and other commerical
organizations to support it regardless of what your current view is
on this topic.

Even within the BSD/OS group at BSDi/WindRiver, (/me former BSD/OS
engineer) some kind of dedicated async IO system inside kernel was
talked about as highly desireable and possibly a more direct way
of dealing with VM page/async IO event issues that don't map
conceptually to a scheduler context cleanly.

AIO is good, plain and simple.

bill

