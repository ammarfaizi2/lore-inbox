Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbTHVNf6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 09:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263297AbTHVNf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 09:35:58 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:37548 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S263294AbTHVNf5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 09:35:57 -0400
Date: Fri, 22 Aug 2003 15:35:42 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: <20030822022709.A3640@pclin040.win.tue.nl>
Message-ID: <Pine.GSO.3.96.1030822152231.21464C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003, Andries Brouwer wrote:

>   The others do not, except for the rather special Switch window key.
>   Upon press it produces the LAlt-down, LShift-down, Tab-down, Tab-up sequence;
>   it repeats Tab-down; and upon release it produces the sequence Tab-up,
>   LAlt-up, LShift-up.

 What an interesting "design" of hardware trying to fit some version of
software.  Do you know if the key behaves consitently if either or both
<LAlt> and <LShift> are already depressed?  And do cursor/editor keys work
properly while <Switch_window> is depressed?  Can I unambiguosly map the
sequence the key generates e.g. to a "Multi_key" keysym? :->

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

