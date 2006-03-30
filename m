Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWC3Nv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWC3Nv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWC3Nv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:51:56 -0500
Received: from mail.sw-soft.com ([69.64.46.34]:34184 "EHLO mail.sw-soft.com")
	by vger.kernel.org with ESMTP id S932213AbWC3Nv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:51:56 -0500
Message-ID: <442BE268.60500@sw.ru>
Date: Thu, 30 Mar 2006 17:51:36 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       devel@openvz.org, serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru>	 <20060324211917.GB22308@MAIL.13thfloor.at>	 <m1psk7enfm.fsf@ebiederm.dsl.xmission.com>  <4428F902.1020706@sw.ru> <1143664234.9731.47.camel@localhost.localdomain>
In-Reply-To: <1143664234.9731.47.camel@localhost.localdomain>
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok. This is also easier for us, as it is a usual way of doing things in 
OpenVZ. Will see...

> On Tue, 2006-03-28 at 12:51 +0400, Kirill Korotaev wrote:
>> Eric, we have a GIT repo on openvz.org already:
>> http://git.openvz.org 
> 
> Git is great for getting patches and lots of updates out, but I'm not
> sure it is idea for what we're trying to do.  We'll need things reviewed
> at each step, especially because we're going to be touching so much
> common code.
> 
> I'd guess set of quilt (or patch-utils) patches is probably best,
> especially if we're trying to get stuff into -mm first.
> 
> -- Dave
> 
> 
