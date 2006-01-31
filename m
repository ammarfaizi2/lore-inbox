Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWAaQqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWAaQqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWAaQqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:46:52 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:44195 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751211AbWAaQqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:46:51 -0500
Date: Tue, 31 Jan 2006 11:46:49 -0500
To: Gerhard Mack <gmack@innerfire.net>
Cc: "David S. Miller" <davem@davemloft.net>, diablod3@gmail.com,
       schilling@fokus.fraunhofer.de, bzolnier@gmail.com, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2
Message-ID: <20060131164648.GF18972@csclub.uwaterloo.ca>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <43DCA097.nailGPD11GI11@burner> <200601302043.56615.diablod3@gmail.com> <20060130.174705.15703464.davem@davemloft.net> <Pine.LNX.4.64.0601310609210.2979@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601310609210.2979@innerfire.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 06:13:09AM -0500, Gerhard Mack wrote:
> The downside to that is that while this all gets fought out cd burning on 
> Linux is more of a pain than it should be.

On the other hand, I mostly use DVDs now, and growisofs is just
wonderful, and much easier to work with from the command line.  Maybe
someday we won't care about burning CDs anymore, or maybe growisofs will
add support for it.

Or maybe someone else will maintain a patch that fixes the dumb
"warnings" and such in cdrecord that people can apply to it.  As long as
it doesn't do anything as messy as the pioneer dvd burning patch did.

Len Sorensen
