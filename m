Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbUB1DWb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 22:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbUB1DWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 22:22:31 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53393
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263114AbUB1DWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 22:22:30 -0500
Date: Sat, 28 Feb 2004 04:22:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040228032230.GN8834@dualathlon.random>
References: <20040227122936.4c1be1fd.akpm@osdl.org> <Pine.LNX.4.44.0402271544520.1747-100000@chimarrao.boston.redhat.com> <20040227212844.GJ8834@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227212844.GJ8834@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 10:28:44PM +0100, Andrea Arcangeli wrote:
> on the 64G boxes. I wanted to do page clustering but there are too many

for the record with page clustering above I meant the patch developed
originally by Hugh for 2.4.7 and then developed and currently maintained
by William on kernel.org.
