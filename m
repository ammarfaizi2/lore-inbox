Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270607AbTGTCjX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 22:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270611AbTGTCjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 22:39:22 -0400
Received: from thunk.org ([140.239.227.29]:60603 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S270607AbTGTCh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 22:37:57 -0400
Date: Sat, 19 Jul 2003 20:07:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Bradford <john@grabjohn.com>
Cc: lkml@lrsehosting.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, lm@bitmover.com, rms@gnu.org,
       Valdis.Kletnieks@vt.edu
Subject: Re: [OT] HURD vs Linux/HURD
Message-ID: <20030720000716.GA1085@think>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	John Bradford <john@grabjohn.com>, lkml@lrsehosting.com,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
	lm@bitmover.com, rms@gnu.org, Valdis.Kletnieks@vt.edu
References: <200307191503.h6JF3tac002376@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307191503.h6JF3tac002376@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 04:03:55PM +0100, John Bradford wrote:
> > Given that large chunks of HURD come from Linux, please refer to it as
> > Linux/HURD.
> 
> What HURD code comes from Linux?  GNU/Mach uses code from Linux, but
> not HURD as far as I know.

As far as I know, HURD is using ext2fs code.  It should definitely be
called HURD/Linux.  :-)

						- Ted
