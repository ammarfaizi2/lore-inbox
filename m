Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318895AbSHSNxJ>; Mon, 19 Aug 2002 09:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318894AbSHSNxI>; Mon, 19 Aug 2002 09:53:08 -0400
Received: from [209.167.240.9] ([209.167.240.9]:7414 "EHLO
	ottonexc1.peregrine.com") by vger.kernel.org with ESMTP
	id <S318893AbSHSNxI>; Mon, 19 Aug 2002 09:53:08 -0400
Subject: Re: IDE?
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020817181624.GM10730@lug-owl.de>
References: <20020817181624.GM10730@lug-owl.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Aug 2002 09:57:11 -0400
Message-Id: <1029765431.32209.77.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-17 at 14:16, Jan-Benedict Glaw wrote:
> That's bad. Then, you're nailed to use old kernels without having
> possibilities of recent kernels only because you're working with eg. old
> Alphas, PCMCIA-IDE things or so? Bad, bad, badhorribly bad. Even it's
> sloooow, there'll always some need for PIO-only controller support...

Correct me if I'm wrong, but isn't this already the case?

Are there not several uses of 2.0.x that are not compatible with
2.2/2.4?  And if 2.0 is working, then why are you worried about
being able to use 3.2?  Why do we need to maintain compatibility
with OLD (not 'low-end' but OLD) hardware if there's an existing
kernel that meets that hardware's needs already?

Dana Lacoste
Ottawa

