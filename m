Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423618AbWJaUja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423618AbWJaUja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423620AbWJaUja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:39:30 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:5646 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1423618AbWJaUj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:39:29 -0500
Date: Tue, 31 Oct 2006 21:39:28 +0100
From: Olivier Galibert <galibert@pobox.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Cooling the cache
Message-ID: <20061031203928.GA34717@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20061031171204.GA8230@dspnet.fr.eu.org> <20061031172310.GA30739@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061031172310.GA30739@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 06:23:10PM +0100, Jörn Engel wrote:
> On Tue, 31 October 2006 18:12:04 +0100, Olivier Galibert wrote:
> > 
> > In order to measure reliably some worst-case latencies, is there a way
> > to have the system (cleanly) drop as much as possible of its
> > page/directory cache?  Being able to specify which device would be a
> > plus ;-)
> 
> grep -A5 drop_caches Documentation/filesystems/proc.txt

Excellent, thanks.

  OG.
