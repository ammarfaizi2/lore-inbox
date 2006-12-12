Return-Path: <linux-kernel-owner+w=401wt.eu-S932558AbWLLW7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWLLW7i (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWLLW7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:59:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41449 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932558AbWLLW7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:59:37 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrew de Quincey <adq_dvb@lidskialf.net>,
       Cedric Le Goater <clg@fr.ibm.com>, containers@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       v4l-dvb-maintainer@linuxtv.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH/RFC] kthread API conversion for dvb_frontend and av7110
References: <45019CC3.2030709@fr.ibm.com> <4509C4A5.5030600@fr.ibm.com>
	<20060914221024.GB26916@MAIL.13thfloor.at>
	<200611170150.02207.adq_dvb@lidskialf.net>
Date: Tue, 12 Dec 2006 15:58:16 -0700
In-Reply-To: <200611170150.02207.adq_dvb@lidskialf.net> (Andrew de Quincey's
	message of "Fri, 17 Nov 2006 01:50:01 +0000")
Message-ID: <m1ejr4rabb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew de Quincey <adq_dvb@lidskialf.net> writes:

> [snip]
>
>> correct, will fix that up in the next round
>>
>> thanks for the feedback,
>> Herbert
>
> Hi - the conversion looks good to me.. I can't really offer any more 
> constructive suggestions beyond what Cedric has already said. 
>
> Theres another thread in dvb_ca_en50221.c that could be converted as well 
> though, hint hint ;)
>
> Apologies for the delay in this reply - I've been hibernating for a bit.

Guys where are we at on this conversion?

Eric
