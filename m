Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129471AbQJ0TRl>; Fri, 27 Oct 2000 15:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129617AbQJ0TRc>; Fri, 27 Oct 2000 15:17:32 -0400
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:18904 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129471AbQJ0TRT>; Fri, 27 Oct 2000 15:17:19 -0400
Date: Fri, 27 Oct 2000 20:17:11 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
To: David Schwartz <davids@webmaster.com>
cc: Jason Wohlgemuth <jswkernel@triad.rr.com>, linux-kernel@vger.kernel.org
Subject: RE: GPL Question
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKMEJFLIAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.10.10010272013140.13264-100000@dax.joh.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000, David Schwartz wrote:

> 
> > Now, if a module is loaded that registers a set of functions that have
> > increased functionality compared to the original functions, if that
> > modules is not based off GPL'd code, must the source code of that module
> > be released under the GPL?
> 
> 	If the answer to this is "yes", then Microsoft should own some rights to
> every piece of software that uses the Windows API.

In fact, since you call the Windows API by linking against Windows
libraries (kernel32.dll etc), Microsoft have as much right to dictate the
licensing of Windows apps as the FSF has to require apps linked against
GPLed code to be GPLed. (IMO, neither has any such right; of course, given
the spate of recent laws we've seen, I wouldn't put any faith in a legal
system to reach the "right" decision...)

In this particular case - just communicating with GPLed code - the answer
is no, you are not required to impose GPL restrictions on your users, you
can use a free license instead (or a proprietary one, if you really
want...)


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
