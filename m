Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbTJAJyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 05:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbTJAJyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 05:54:40 -0400
Received: from main.gmane.org ([80.91.224.249]:40611 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261458AbTJAJyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 05:54:39 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet.2117@andreas-s.net>
Subject: Re: Call traces due to lost IRQ
Date: Wed, 1 Oct 2003 09:54:36 +0000 (UTC)
Message-ID: <slrnbnl939.3s7.usenet.2117@home.andreas-s.net>
References: <20030930154032.GA795@donald.balu5> <20030930112429.A722@osdlab.pdx.osdl.net> <slrnbnjksd.3pa.usenet.2117@home.andreas-s.net> <20030930135934.B722@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Andreas Schwarz (usenet.2117@andreas-s.net) wrote:
>> This solved the issue for me.
>
> Great, although I'm a bit confused.  In your last mail you said you were
> using 2.6.0-test6-mm1.  That patch is already in mm1, so were you using
> plain 2.6.0-test6 by any chance?

Gentoo calls the ebuild 2.6.0-test6-mm1, but maybe the patches were not
applied correctly... I'll check that.

-- 
AVR-Tutorial, über 350 Links
Forum für AVRGCC und MSPGCC
-> http://www.mikrocontroller.net

