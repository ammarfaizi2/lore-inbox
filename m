Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVKXO5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVKXO5d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVKXO5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:57:33 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:9154 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751260AbVKXO5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:57:32 -0500
Date: Thu, 24 Nov 2005 15:57:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: david singleton <dsingleton@mvista.com>
Cc: "David F. Carlson" <dave@chronolytics.com>,
       Dinakar Guniguntala <dino@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: PI BUG with -rt13
Message-ID: <20051124145734.GA2717@elte.hu>
References: <20051117161817.GA3935@in.ibm.com> <437D0C59.1060607@mvista.com> <20051118092909.GC4858@elte.hu> <20051118132137.GA5639@in.ibm.com> <20051118132715.GA3314@elte.hu> <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com> <20051118174454.GA2793@elte.hu> <43822480.6080301@mvista.com> <20051121212653.GA6143@elte.hu> <EDDB1894-5AFB-11DA-A840-000A959BB91E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDDB1894-5AFB-11DA-A840-000A959BB91E@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* david singleton <dsingleton@mvista.com> wrote:

> Sure.  Attached is the locking fix patch. [...]

thanks, applied - it should show up in -rt15.

	Ingo
