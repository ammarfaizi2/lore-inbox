Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTDRSeV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 14:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbTDRSeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 14:34:21 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:42250
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263199AbTDRSeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 14:34:20 -0400
Subject: Re: 2.5.67-mm4: select-speedup.patch breaks Evolution
From: Robert Love <rml@tech9.net>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: akpm@digeo.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1050687280.595.3.camel@teapot.felipe-alfaro.com>
References: <1050687280.595.3.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1050691576.745.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 18 Apr 2003 14:46:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-18 at 13:34, Felipe Alfaro Solana wrote:
> 2.5.67-mm4 breaks Evolution 1.2.3: when clicking on "Sending/Receiving"
> toolbar button, Evolution displays the progress dialog box but it hangs
> forever, that is, no mail is sent or received. All my accounts are POP3.

Noted here, too.

> Reverting "select-speedup.patch" fixes the problem.

Same here, too.

Something is not quite right in there.  It is a fairly large change...

	Robert Love

