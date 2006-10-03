Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWJCOiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWJCOiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 10:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWJCOiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 10:38:06 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:27657 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932269AbWJCOiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 10:38:03 -0400
Date: Tue, 3 Oct 2006 10:30:18 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Dan Williams <dcbw@redhat.com>
Cc: Theodore Tso <tytso@mit.edu>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, jt@hpl.hp.com,
       Andrew Morton <akpm@osdl.org>, Norbert Preining <preining@logic.at>,
       hostap@shmoo.com, linux-kernel@vger.kernel.org,
       ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003143012.GC23912@tuxdriver.com>
References: <20061002111537.baa077d2.akpm@osdl.org> <20061002185550.GA14854@bougret.hpl.hp.com> <200610022147.03748.rjw@sisk.pl> <1159822831.11771.5.camel@localhost.localdomain> <20061002212604.GA6520@thunk.org> <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com> <1159877574.2879.11.camel@localhost.localdomain> <20061003124902.GB23912@tuxdriver.com> <20061003133845.GG2930@thunk.org> <1159884779.2855.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159884779.2855.18.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 10:12:59AM -0400, Dan Williams wrote:
> On Tue, 2006-10-03 at 09:38 -0400, Theodore Tso wrote:

> > John, has the wireless community considered creating a new interface
> > which *is* carefully designed, and supporting both the new and the
> > legacy interface for 2-3 years until all of the mainstream
> 
> Yes, nl80211/cfg80211 (sent to netdev@ last week) is the likely
> successor.  Please, if you have suggestions for ABI/API-proofability,
> review the patch and post suggestions!  We all know a carefully designed
> is not just about the code, but about the semantics, structures, etc as
> well.  It would be quite valuable to have everyone's input to make sure
> it's as future-proof as possible.

Dan is quick on his keyboard today! :-)

As Dan points-out, there is serious work underway on the next
generation wireless management A[BP]I.  That work is (perhaps
unfortunately) closely linked to the new wireless stack work currently
underway.

John

P.S.  Ted, thanks for your calm and respectful communications!
-- 
John W. Linville
linville@tuxdriver.com
