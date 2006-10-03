Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWJCRIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWJCRIZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWJCRIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:08:25 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:48364 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1030333AbWJCRIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:08:24 -0400
Date: Tue, 3 Oct 2006 10:03:45 -0700
To: Theodore Tso <tytso@mit.edu>, Dan Williams <dcbw@redhat.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, jt@hpl.hp.com,
       Andrew Morton <akpm@osdl.org>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003170345.GE17252@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002185550.GA14854@bougret.hpl.hp.com> <200610022147.03748.rjw@sisk.pl> <1159822831.11771.5.camel@localhost.localdomain> <20061002212604.GA6520@thunk.org> <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com> <1159877574.2879.11.camel@localhost.localdomain> <20061003124902.GB23912@tuxdriver.com> <20061003133845.GG2930@thunk.org> <1159884779.2855.18.camel@localhost.localdomain> <20061003160041.GC29333@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003160041.GC29333@thunk.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 12:00:41PM -0400, Theodore Tso wrote:
> 
> Consider that that the normal, MINIMUM waiting period for *removing*
> an interface or functionality is six months.  I would argue that this
> means that we should be waiting that long before making
> backwards-incompatible changes to an interface should be at least that
> long.

	Wireless Tools with the new API were released in
April. wpa_supplicant with the new API was release May 5th. That makes
it 6 months.
	Wireless Tools v28 was included in Gentoo April 11th and in
Debian testing May 27th. wpa_supplicant 0.4.9 was included in Gentoo
May 27th and Debian testing June 10th.

	Please consider the facts before assuming.

	Jean
