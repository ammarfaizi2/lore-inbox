Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTKKIwh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 03:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTKKIwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 03:52:37 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:20967 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S263453AbTKKIwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 03:52:36 -0500
Date: Tue, 11 Nov 2003 09:52:29 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031111085229.GB22283@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <1068512710.722.161.camel@cube> <20031110205011.R10197@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031110205011.R10197@schatzie.adilger.int>
X-Operating-System: vega Linux 2.6.0-test9 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 08:50:12PM -0700, Andreas Dilger wrote:
> On Nov 10, 2003  20:05 -0500, Albert Cahalan wrote:
> > > It is too simple to implement in user mode.
> > 
> > That works for a plain byte-stream on a
> > local UNIX-style filesystem. (though it
> > likely isn't the fastest)

It would be something similar than sendfile() ?


- Gábor (larta'H)
