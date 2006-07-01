Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWGAAwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWGAAwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 20:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWGAAwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 20:52:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54938 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751884AbWGAAwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 20:52:33 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: hadi@cyberus.ca
Cc: Sam Vilain <sam@vilain.net>, Herbert Poetzl <herbert@13thfloor.at>,
       viro@ftp.linux.org.uk, devel@openvz.org, dev@sw.ru,
       Andrew Morton <akpm@osdl.org>, clg@fr.ibm.com, serue@us.ibm.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Daniel Lezcano <dlezcano@fr.ibm.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@swsoft.com>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
	<44A1689B.7060809@candelatech.com>
	<20060627225213.GB2612@MAIL.13thfloor.at>
	<1151449973.24103.51.camel@localhost.localdomain>
	<20060627234210.GA1598@ms2.inr.ac.ru>
	<m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>
	<20060628133640.GB5088@MAIL.13thfloor.at>
	<1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net>
	<1151626552.8922.70.camel@jzny2>
	<20060630114551.A20191@castle.nmd.msu.ru>
	<1151675452.5270.10.camel@jzny2>
	<m13bdmbj1b.fsf@ebiederm.dsl.xmission.com>
	<1151704319.5270.317.camel@jzny2>
Date: Fri, 30 Jun 2006 18:50:20 -0600
In-Reply-To: <1151704319.5270.317.camel@jzny2> (hadi@cyberus.ca's message of
	"Fri, 30 Jun 2006 17:51:58 -0400")
Message-ID: <m1u0629mib.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal <hadi@cyberus.ca> writes:

> On Fri, 2006-30-06 at 12:22 -0600, Eric W. Biederman wrote:
>
>> 
>> Anyway Jamal can you see the problem the aliases present to the
> implementation?
>> 
>
> I think more than anything i may have a different view of things and no
> code ;-> And you are trying to restore order in the discussion - so my
> wild ideas dont help. If you guys have a meeting somewhere like this
> coming OLS I will come over and disrupt your meeting ;-> I actually have
> attempted to implement things like virtual routers but you guys seem way
> ahead of anywhere i was.

Currently I think we have both a talk, and a BOFH at OLS plus probably
a little time at kernel summit.

Eric
