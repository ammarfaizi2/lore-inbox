Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUGLJfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUGLJfJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 05:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266770AbUGLJfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 05:35:09 -0400
Received: from mproxy.gmail.com ([216.239.56.243]:33549 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266768AbUGLJfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 05:35:04 -0400
Message-ID: <4d8e3fd3040712023469039826@mail.gmail.com>
Date: Mon, 12 Jul 2004 11:34:59 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.8-rc1
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004 11:29:44 -0700 (PDT), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> Ok, there's been a long time between "public" releases, although the
> automated BK snapshots have obviously been keeping people up-to-date.
> Sorry about that, I blame mainly moving boxes and stuff around...

Maybe I'm just missing the whole point but I wonder if we could define
a series of 'test' a version should pass before being marked as -rc ir
final.

Now that we have the automated BK snapshots the "public" release seems
to be a minor milestone in the process.

I would like to see ltp test suite, OSDL's compile stats and OSDL
benchmarking as part of the release process.

Does it make sense ?

Ciao,
                             Paolo

-- 
paoloc.doesntexist.org
