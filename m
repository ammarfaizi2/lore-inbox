Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbUCJHeM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 02:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbUCJHeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 02:34:12 -0500
Received: from may.nosdns.com ([207.44.240.96]:55526 "EHLO may.nosdns.com")
	by vger.kernel.org with ESMTP id S262260AbUCJHeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 02:34:08 -0500
Date: Wed, 10 Mar 2004 00:26:32 -0700
From: Elikster <elik@webspires.com>
X-Mailer: The Bat! (v2.04.4) Personal
Reply-To: Elikster <elik@webspires.com>
Organization: WebSpires Technologies
X-Priority: 3 (Normal)
Message-ID: <187223550.20040310002632@webspires.com>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: Darren's ipfilter ported to linux
In-Reply-To: <20040310061359.GL1653@mea-ext.zmailer.org>
References: <1078895385.2559.29.camel@amnesiac>
 <404EA4C5.2050509@matchmail.com> <20040310061359.GL1653@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - may.nosdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - webspires.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings folks,

    *Groans*  Do we need another revision here again?  It is pain in the butt going from ipf to ipchains and then to Iptables.  Just going over to ipfilter from Iptables is just asking for suicide among lot us if we going to be using the new filter system.

    Just improve on Iptables and stick with it. :)  I don't feel like learning another ip filtering system all over again after going though 3 changes. :)

    Although, it would be nice if we can add the natural language filtering system to the IPtables, something akin to this line:

    REJECT 32.31.38.83:80 INPUT, which make it lot easier than the IPTables setup, but it is just me wishing. :)

Tuesday, March 9, 2004, 11:13:59 PM, you wrote:

MA> On Tue, Mar 09, 2004 at 09:16:53PM -0800, Mike Fedyk wrote:
>> Jett Tayer wrote:
>> >Hi,
>> >
>> >When will this be integrated to the kernel???
>> 
>> Why should it be?
>> What does it gain us?
>> Is it GPL?

MA>   It is (probably) "Darren Reed's ipfilter", aka BSD ipf(ilter).

MA>   Having used ipf, ipchains, iptables, etc. in different system,
MA>   I take iptables any day.   YMMV, etc.

MA> /Matti Aarnio
MA> -
MA> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
MA> the body of a message to majordomo@vger.kernel.org
MA> More majordomo info at  http://vger.kernel.org/majordomo-info.html
MA> Please read the FAQ at  http://www.tux.org/lkml/




-- 
Best regards,
 Elikster                            mailto:elik@webspires.com

