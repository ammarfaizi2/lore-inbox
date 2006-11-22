Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756978AbWKVIox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978AbWKVIox (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 03:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756980AbWKVIox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 03:44:53 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3037 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1756977AbWKVIow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 03:44:52 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dmitry Mishin <dim@openvz.org>
Cc: Daniel Lezcano <dlezcano@fr.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Cedric Le Goater <clg@fr.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       netdev@vger.kernel.org
Subject: Re: [patch -mm] net namespace: empty framework
References: <4563007B.9010202@fr.ibm.com> <4563046B.6040909@sw.ru>
	<45633EDF.3050309@fr.ibm.com> <200611221121.59322.dim@openvz.org>
Date: Wed, 22 Nov 2006 01:43:51 -0700
In-Reply-To: <200611221121.59322.dim@openvz.org> (Dmitry Mishin's message of
	"Wed, 22 Nov 2006 11:21:58 +0300")
Message-ID: <m1wt5nub08.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Mishin <dim@openvz.org> writes:

> On Tuesday 21 November 2006 21:01, Daniel Lezcano wrote:
>> Kirill Korotaev wrote:
>> > Cedric,
>> >
>> > Dmitry Mishin and Daniel Lezcano are working together on the full
>> > network namespace incorporating both needs of OpenVZ and VServer/IBM.
>> >
>> > Thanks,
>> > Kirill
>>
>> Kirill,
>>
>> We will need this framework to move the network isolation code to the
>> ns_proxy/net_namespace structure. So if Cedric gives us a empty
>> framework it is fine, except if someone does not agree with it...
>>
>>    -- Daniel.
> This patch looks acceptable for us.
> BTW, Daniel, we agreed to be based on the Andrey's patchset. I do not see a 
> reason, why Cedric force us to make some unnecessary work and move existent 
> patchset over his interface.

If you are going to take that attitude.  Where was this conversation?

It appears several relevant people were not aware of this development
discussion.  So when it comes up for general review you can expect your
approach as well as your code to be critiqued.

Eric
