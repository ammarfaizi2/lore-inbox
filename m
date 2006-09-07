Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422693AbWIGWeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422693AbWIGWeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWIGWeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:34:06 -0400
Received: from khc.piap.pl ([195.187.100.11]:41700 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1422704AbWIGWeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:34:02 -0400
To: Chase Venters <chase.venters@clientec.com>
Cc: ellis@spinics.net, w@1wt.eu (Willy Tarreau), linux-kernel@vger.kernel.org
Subject: Re: bogofilter ate 3/5
References: <200609061856.k86IuS61017253@no.spam>
	<Pine.LNX.4.64.0609061409360.18840@turbotaz.ourhouse>
	<m34pvkvhm0.fsf@defiant.localdomain>
	<Pine.LNX.4.64.0609061658440.18840@turbotaz.ourhouse>
	<m37j0fvqkq.fsf@defiant.localdomain>
	<Pine.LNX.4.64.0609070834180.31500@turbotaz.ourhouse>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 08 Sep 2006 00:33:56 +0200
In-Reply-To: <Pine.LNX.4.64.0609070834180.31500@turbotaz.ourhouse> (Chase Venters's message of "Thu, 7 Sep 2006 08:46:56 -0500 (CDT)")
Message-ID: <m3lkovs3vv.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters <chase.venters@clientec.com> writes:

> The problem with trying to stop forgery is that there is not yet a
> foolproof or reasonably foolproof method of doing so.

The first important point here is that vger rejects mail in SMTP
DATA phase, thus making the forgery irrelevant WRT such bounces.
Second, being on the list isn't enough for the message to go
through, it has to pass the filters as everyone else.

Third, while I think "normal" autoresponders (vacation etc.)
are perfectly reasonable (not in mailing list context of course),
ones which by design respond mostly to forged addresses (do you
think antivirus and antispam qualify?) are aimed at the wrong,
innocent person.
-- 
Krzysztof Halasa
