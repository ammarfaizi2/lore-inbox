Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbTLKRE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265176AbTLKRE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:04:57 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:4516 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S265172AbTLKRE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:04:56 -0500
Date: Thu, 11 Dec 2003 18:04:54 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Josh McKinney <forming@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
In-Reply-To: <20031211162303.GA18338@forming>
Message-ID: <Pine.LNX.4.55.0312111801560.19321@jurand.ds.pg.gda.pl>
References: <200312072312.01013.ross@datscreative.com.au>
 <200312101543.39597.ross@datscreative.com.au> <Pine.LNX.4.55.0312101653490.31543@jurand.ds.pg.gda.pl>
 <200312111655.25456.ross@datscreative.com.au> <Pine.LNX.4.55.0312111323180.19321@jurand.ds.pg.gda.pl>
 <20031211162303.GA18338@forming>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Josh McKinney wrote:

> Should I try it with just the acpi fixes sent by Maciej or are these
> just general fixes?

 They should make (at least some of) the reported problems go away,
superseding the respective workarounds.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
