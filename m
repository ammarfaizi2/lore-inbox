Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbTHUMAZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 08:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTHUMAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 08:00:25 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:6784 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262640AbTHUMAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 08:00:21 -0400
Date: Thu, 21 Aug 2003 13:11:53 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308211211.h7LCBrdf000281@81-2-122-30.bradfords.org.uk>
To: aebr@win.tue.nl, macro@ds2.pg.gda.pl
Subject: Re: Input issues - key down with no key up
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       vojtech@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Note the translation is done outside the keyboard -- the onboard 8042
> controller is responsible for it.

How do we currently handle devices connected via bit-banging on the
parallel port,(as we have no onboard 8042 in that case)?

John
