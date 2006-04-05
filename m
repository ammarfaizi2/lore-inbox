Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWDEBTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWDEBTn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 21:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWDEBTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 21:19:43 -0400
Received: from morbo.e-centre.net ([66.154.82.3]:47612 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP
	id S1751044AbWDEBTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 21:19:43 -0400
X-ASG-Debug-ID: 1144199977-21504-83-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: + isdn4linux-siemens-gigaset-drivers-logging-usage.patch added
	to -mm tree
Subject: Re: + isdn4linux-siemens-gigaset-drivers-logging-usage.patch added
	to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org, hjlipp@web.de, kkeil@suse.de
In-Reply-To: <4432FABE.1000900@imap.cc>
References: <200604040051.k340p0RI008205@shell0.pdx.osdl.net>
	 <1144113590.3067.4.camel@laptopd505.fenrus.org>  <4432FABE.1000900@imap.cc>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 03:19:38 +0200
Message-Id: <1144199982.3047.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10492
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-05 at 01:01 +0200, Tilman Schmidt wrote:
> On 04.04.2006 03:19, Arjan van de Ven wrote:
> 
> >>+	struct semaphore sem;		/* locks this structure:
> [...]
> > 
> > please consider turning this into a mutex 
> 
> Your wish is our command. Consider it already done. :-)
> 

great!

apologies for missing that; that's what you get for trusting mail
filters to trigger on patch fragments ;(


