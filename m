Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVFUUKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVFUUKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVFUUIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:08:40 -0400
Received: from peabody.ximian.com ([130.57.169.10]:39848 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261453AbVFUUHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:07:55 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Robert Love <rml@novell.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: Zan Lynx <zlynx@acm.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0506211306060.22372@graphe.net>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <42B831B4.9020603@pobox.com> <1119368364.3949.236.camel@betsy>
	 <Pine.LNX.4.62.0506211222040.21678@graphe.net>
	 <1119382685.3949.263.camel@betsy> <1119384131.15478.25.camel@localhost>
	 <Pine.LNX.4.62.0506211306060.22372@graphe.net>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 16:07:53 -0400
Message-Id: <1119384473.3949.279.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 13:06 -0700, Christoph Lameter wrote:
> On Tue, 21 Jun 2005, Zan Lynx wrote:
> 
> > I've never tried doing that.  It might work, for all I know.
> 
> I was told that Linux cannot do this. It always returns the filehandles as 
> ready for disk files.

Inotify would definitely work.

	Robert Love


