Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262915AbTCKMa6>; Tue, 11 Mar 2003 07:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262914AbTCKMa6>; Tue, 11 Mar 2003 07:30:58 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:48650 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S262915AbTCKMa5>; Tue, 11 Mar 2003 07:30:57 -0500
Date: Tue, 11 Mar 2003 15:39:49 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: jamal <hadi@cyberus.ca>
Cc: raarts@office.netland.nl, Linus Torvalds <torvalds@transmeta.com>,
       david.knierim@tekelec.com, alexander@netintact.se,
       Donald Becker <becker@scyld.com>, Greg KH <greg@kroah.com>,
       Jeff Garzik <jgarzik@pobox.com>, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, Robert Olsson <Robert.Olsson@data.slu.se>
Subject: Re: [fixed] Re: PCI init issues
Message-ID: <20030311153949.A24078@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0303041046370.1426-100000@home.transmeta.com> <3E6601A3.2010201@netland.nl> <20030307221916.A3679@localhost.park.msu.ru> <20030310134122.S88416@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030310134122.S88416@shell.cyberus.ca>; from hadi@cyberus.ca on Mon, Mar 10, 2003 at 01:43:50PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 01:43:50PM -0500, jamal wrote:
> Is there more testing youd like to see done?

Yes, it would be interesting to test this on similar motherboards
(with E7500 chipset) which do work without that patch, just to make
sure it doesn't break something.

> Could we get this patch in to Marcello for inclusion in the pre 2.4.21?

Why not, but I'd like to clean it up first (will do in a next
couple of days).

Ivan.
