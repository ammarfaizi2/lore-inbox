Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272955AbTG3QXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272960AbTG3QXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:23:14 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:523 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S272955AbTG3QXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:23:13 -0400
Date: Wed, 30 Jul 2003 12:02:12 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Serge A. Suchkov" <ss@e1.bmstu.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 bugreport
In-Reply-To: <03072912312701.10545@XP1700>
Message-ID: <Pine.LNX.3.96.1030730120100.31524A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Serge A. Suchkov wrote:

> 
> Hi,
> 
> I"m test 2.6.0-test2, quick bugreport below...
> 
> 
> 1) No logo in vesafb ;) (in 2.6.0-test1 logo present)

There appears to be a problem with dependencies, if you just do a make
again it seems to work (did for me).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

