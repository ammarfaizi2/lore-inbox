Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbVLKFfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbVLKFfq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 00:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbVLKFfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 00:35:46 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:63454
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1161091AbVLKFfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 00:35:45 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Sat, 10 Dec 2005 23:33:02 -0600
User-Agent: KMail/1.8
Cc: Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
References: <20051203135608.GJ31395@stusta.de> <200512071214.26574.rob@landley.net> <439ADAF3.9040705@tmr.com>
In-Reply-To: <439ADAF3.9040705@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512102333.02855.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 December 2005 07:41, Bill Davidsen wrote:
> Given that CL has minimal (essentially no) maintenence cost,

then by your own admission maintaining it as an external patch for people who 
need it for legacy reasons is trivial, and removing it to discourage new 
users from picking it up remains a good idea.

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
