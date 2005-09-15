Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVIOXUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVIOXUO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 19:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVIOXUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 19:20:14 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:22703
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751157AbVIOXUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 19:20:13 -0400
Subject: Re: 2.6.13-rt6, ktimer subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: george@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <4329FDF7.7080300@mvista.com>
References: <20050913100040.GA13103@elte.hu> <43287C52.7050002@mvista.com>
	 <20050915092008.GA17915@elte.hu>  <4329FDF7.7080300@mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 16 Sep 2005 01:20:31 +0200
Message-Id: <1126826431.6509.546.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-15 at 16:04 -0700, George Anzinger wrote:

> Possibly your involvement was that short.  I rather doubt the code was 
> written that quickly...  I first found out about it on the 12th from the 
> rt5 patch you posted about 2pm.  Was there an earlier email?

The first sketch of ktimers was written in less than a day. Some
cleanups and the integration into -RT took not longer than 3-4 days.

tglx


