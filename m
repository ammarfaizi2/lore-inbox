Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274964AbTHRU3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274969AbTHRU3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:29:54 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10506
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S274964AbTHRU3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:29:53 -0400
Date: Mon, 18 Aug 2003 13:29:49 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030818202949.GD10320@matchmail.com>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
References: <3F325198.2010301@namesys.com> <20030807153257.1f2f80b0.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807153257.1f2f80b0.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 03:32:57PM +0200, Stephan von Krawczynski wrote:
> On Thu, 07 Aug 2003 17:18:16 +0400
> Hans Reiser <reiser@namesys.com> wrote:
> 
> > >On Thu, 7 Aug 2003, Stephan von Krawczynski wrote:
> > >>for this one. Hint: spelling in reiserfsck should be checked ;-)
> > >
> > where?
> 
> Hello Hans,
> 
> I am no native english, but 
> "Comparing bitmaps.. vpf-10640: The on-disk and the correct bitmaps differs"
> feels uncomfortable in my ears ;-)
> I'd say "two things differ", without trailing "s". I am not even sure if
> "bitmaps" shouldn't be singular "bitmap" instead.

"bitmaps" with your changes would be correct.

Though, just turn "bitmaps" into "bitmap" and it should be fine.  I can't
really think of a phrase specific enough for the error message without
adding enough text to make it two lines, which wouldn't be good.

"Comparing bitmaps.. vpf-10640: The on-disk and the correct bitmap differs"
