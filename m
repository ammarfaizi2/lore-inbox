Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUAMUXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUAMUXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:23:35 -0500
Received: from certiflexdimension.com ([66.137.233.209]:60849 "EHLO
	werewolf.certiflexdimension.com") by vger.kernel.org with ESMTP
	id S265148AbUAMUXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:23:33 -0500
Date: Tue, 13 Jan 2004 14:23:57 -0600
From: Jonathan Angliss <jon@netdork.net>
Reply-To: Jonathan Angliss <jon@netdork.net>
X-Priority: 3 (Normal)
Message-ID: <1147750391.20040113142357@netdork.net>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: athlon-xp header issue
In-Reply-To: <20040113191217.GA29400@redhat.com>
References: <398633829.20040113113000@netdork.net>
 <20040113191217.GA29400@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

Tuesday, January 13, 2004, 1:12:17 PM, you wrote:

>> This gave me a hint. So I took a look in arch/i386/config.in and
>> noticed that the check for CONFIG_MK7XP is missing. This results in
>> the appropriate settings not being set. Is this intentional? Or am
>> I looking in the wrong area for my problem?

> CONFIG_MK7XP is a gentoo specific bogon. Bug them about it. (For
> info on why its bogus, search the linux-kernel archives, as it comes
> up every few months.)

Thanks for the response.  I shall jump on them about it.

-- 
Jonathan Angliss
(jon@netdork.net)

Never mind the star, get those camels off my lawn!

