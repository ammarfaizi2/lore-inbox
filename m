Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbTGDMgG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 08:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266008AbTGDMgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 08:36:06 -0400
Received: from zamok.crans.org ([138.231.136.6]:61100 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S265955AbTGDMgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 08:36:05 -0400
Date: Fri, 4 Jul 2003 14:50:30 +0200
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <20030704125030.GA914@darwin.crans.org>
References: <20030703023714.55d13934.akpm@osdl.org> <3F054109.2050100@aitel.hist.no> <20030704093531.GA26348@holomorphy.com> <20030704095004.GB26348@holomorphy.com> <20030704100217.GC26348@holomorphy.com> <20030704100749.GD26348@holomorphy.com> <3F05610C.4050202@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F05610C.4050202@aitel.hist.no>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.4i
From: Vincent Hanquez <tab@tuxfamily.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 01:12:12PM +0200, Helge Hafting wrote:
> I applied both of your recent patches, and the patched
> 2.5.74-mm1 kernel came up fine. :-)

theses patchs fix the problem for me too.

-- 
Tab
