Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbTJ0CPX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 21:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbTJ0CPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 21:15:22 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:25104 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263740AbTJ0CPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 21:15:20 -0500
Date: Sun, 26 Oct 2003 18:15:14 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031027021514.GC5198@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <20031017094443.GA7738@elf.ucw.cz> <20031017182321.GB145@pegasys.ws> <20031027020844.GC4511@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027020844.GC4511@matchmail.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Unauthorised duplication and storage of this email is a violation of international copyright law and is subject to prosecution.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 06:08:44PM -0800, Mike Fedyk wrote:
> On Fri, Oct 17, 2003 at 11:23:21AM -0700, jw schultz wrote:
> > The probability of false positives in rsync are orders of
> > magnitude smaller than they would be in a block hashing
> > filesystem.  Yet we were seeing it happen (with truncated
> > hash) at measurable rates on files as small as a few hundred
> > megabytes.  It was almost commonplace on iso images.
> 
> So has there been anything done to solve this problem in rsync?

Yes.  Hence the use of the past tense.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
