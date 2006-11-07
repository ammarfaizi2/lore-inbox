Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754253AbWKGSaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbWKGSaf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754251AbWKGSaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:30:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21948 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751880AbWKGSae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:30:34 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       olson@pathscale.com
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	<20061105064801.GV13381@stusta.de>
	<m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>
	<20061107042214.GC8099@stusta.de> <45501730.8020802@serpentine.com>
	<m1psbzbpxw.fsf@ebiederm.dsl.xmission.com>
	<4550B22C.1060307@serpentine.com>
	<m18xinb1qn.fsf@ebiederm.dsl.xmission.com>
	<4550C9ED.9050308@serpentine.com>
Date: Tue, 07 Nov 2006 11:29:53 -0700
In-Reply-To: <4550C9ED.9050308@serpentine.com> (Bryan O'Sullivan's message of
	"Tue, 07 Nov 2006 10:01:17 -0800")
Message-ID: <m1ejsf9kke.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@serpentine.com> writes:

> Eric W. Biederman wrote:
>
>> If you really need to write to both the config space registers and your
>> magic shadow copy of the register I can certainly do the config space
>> writes for you.  I just figured it would be more efficient not to.
>
> Yes, we need to do both.
>
> I've got code that refactors your patch a little as I try to get the driver
> happy, but so far it's not seeing any interrupts.  I'll keep you posted.

Ok.  Thanks.

Eric
