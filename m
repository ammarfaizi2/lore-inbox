Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbTHSXsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 19:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTHSXsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 19:48:46 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:3573 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261524AbTHSXsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 19:48:45 -0400
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bhtt73$8i4$1@gatekeeper.tmr.com>
References: <3F41B43D.6000706@cyberone.com.au>
	 <1061276043.6974.33.camel@orbiter>  <bhtt73$8i4$1@gatekeeper.tmr.com>
Content-Type: text/plain
Message-Id: <1061336922.1120.4.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 19:48:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | diff with frequents kernel releases. having a structure in place to
> | plug-in other schedulers sure helps.
> 
> I agree. In fact I'm pretty sure I said something similar a while ago.
> Unlike you I didn't do any major changes, certainly none I felt were of

Of course, i was thinking 

