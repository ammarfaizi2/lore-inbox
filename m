Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTLVM3u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 07:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTLVM3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 07:29:50 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:23047 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264394AbTLVM3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 07:29:48 -0500
Date: Mon, 22 Dec 2003 04:32:54 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: pj@sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ioe-lkml@rameria.de
Subject: Re: [PATCH] another minor bit of cpumask cleanup
Message-Id: <20031222043254.0db129a9.pj@sgi.com>
In-Reply-To: <20031222085752.GB27687@holomorphy.com>
References: <20031221180044.0f27eca1.pj@sgi.com>
	<20031221224745.268db46d.akpm@osdl.org>
	<20031221231918.34fcca86.pj@sgi.com>
	<20031222085752.GB27687@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli wrote:
> so as to counter the implication that all I did back then was
> crap gibberish all over the tree

Sorry you're feeling picked on and under appreciated.

It really doesn't matter to me by whom or how this came to be.  More
than once in my career, I have cleaned up some stuff, then out of
curiosity gone back to see who might have written such crap -- only to
discover it was I.  I've learned to not ask such questions.  Just keep
on trying to make things better.

We are working on a large and ever changing body of code with thousands
of others active at any point.  The opportunities for refinement and
improvement are endless.  Don't sweat how we got here; those who have
done the most (such as yourself) probably have created the most
"opportunities" for further refinment.  Just judge each change on its
current merits, and on whether it moves in the right long term
directions.

See further:
    Ten Commandments of Egoless Programming
    http://builder.com.com/5100-6404-1045782.html

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
