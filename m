Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271391AbTHRLyB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 07:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271407AbTHRLyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 07:54:01 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:24752 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S271391AbTHRLx7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 07:53:59 -0400
Date: Mon, 18 Aug 2003 13:53:49 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: John Bradford <john@grabjohn.com>
cc: jamie@shareable.org, aebr@win.tue.nl, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au, vojtech@suse.cz
Subject: Re: Input issues - key down with no key up
In-Reply-To: <200308161515.h7GFFeUS000159@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.GSO.3.96.1030818134629.12013A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003, John Bradford wrote:

> > What are the known problems with mode #3, then?
> 
> It's poorly implemented by a lot of keyboards.

 Specifically, it wasn't used much at the beginning (see e.g. when we came
to trying it -- it's already ~15 years since it was introduced) and then
the crapware era began and some manufacturers stopped taking care of less
commonly used standard functionality. 

> Has anybody actually verified that the keyboards that are presenting
> the problem in quesiton are not specifically identifyable by their ID
> string, or some other means - E.G. they only exist on specific, known
> laptops?

 I recall testing an i486 laptop around 1996 and not only it accepted
switching mode to #3, but it reported it as being active then as well. 
Yet it generated #2 codes regardless... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

