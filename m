Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbTAXTb3>; Fri, 24 Jan 2003 14:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbTAXTb3>; Fri, 24 Jan 2003 14:31:29 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:36779 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S264620AbTAXTb2>; Fri, 24 Jan 2003 14:31:28 -0500
Date: Fri, 24 Jan 2003 20:40:04 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: David Lang <david.lang@digitalinsight.com>
cc: "Anoop J." <cs99001@nitc.ac.in>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <Pine.LNX.4.44.0301241110470.10187-100000@dlang.diginsite.com>
Message-ID: <Pine.GSO.3.96.1030124203425.6763A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003, David Lang wrote:

> the cache never sees the virtual addresses, it operated excclusivly on the
> physical addresses so the problem of aliasing never comes up.

 It depends on the implementation.

> virtual to physical addres mapping is all resolved before anything hits
> the cache.

 It depends on the processor.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

