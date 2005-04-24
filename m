Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVDXXL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVDXXL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 19:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVDXXL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 19:11:57 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:29627 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S262475AbVDXXL4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 19:11:56 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>
	<87wtr8rdvu.fsf@blackdown.de> <87u0m7aogx.fsf@blackdown.de>
	<1113607416.5462.212.camel@gaston> <877jj1aj99.fsf@blackdown.de>
	<20050423170152.6b308c74.akpm@osdl.org> <87fyxhj5p1.fsf@blackdown.de>
	<1114308928.5443.13.camel@gaston> <426B6C84.E8D41D57@tv-sign.ru>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Oleg Nesterov <oleg@tv-sign.ru>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>, Linux
	Kernel list <linux-kernel@vger.kernel.org>
Date: Mon, 25 Apr 2005 01:11:52 +0200
In-Reply-To: <426B6C84.E8D41D57@tv-sign.ru> (Oleg Nesterov's message of "Sun,
	24 Apr 2005 13:53:08 +0400")
Message-ID: <87u0lvpy6f.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Juergen Kreileder wrote:
>>
>> It only happens when running Azareus with IBM's Java (our's isn't
>> ready yet).  So far I was able to reproduce the problem on all -mm
>> versions within one hour.  Otherwise the kernels seem to work fine
>> -- no lockup unless I run Azareus.
>
> By any chance, could you please try this patch?

Doesn't help.


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
