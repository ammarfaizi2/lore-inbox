Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWCZLfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWCZLfT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 06:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWCZLfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 06:35:19 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:10726 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751255AbWCZLfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 06:35:18 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH] Fix bug: flat binary loader doesn't check fd table full
To: Luke Yang <luke.adi@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>
Reply-To: 7eggert@gmx.de
Date: Sun, 26 Mar 2006 13:34:27 +0200
References: <5Tsh4-2q0-13@gated-at.bofh.it> <5TsTM-3aB-1@gated-at.bofh.it> <5Tuj1-5lw-31@gated-at.bofh.it> <5Tuj1-5lw-29@gated-at.bofh.it> <5U92I-6ki-11@gated-at.bofh.it> <5UiSm-3FG-17@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FNTWV-00013n-WF@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Yang <luke.adi@gmail.com> wrote:
> On 3/25/06, Paul Jackson <pj@sgi.com> wrote:

>> > >   Anyone knows how to avoid "tab to space" converting in gmail?
>> >
>> > If I knew, I'd put it in my .signature :(
>>
>> If you use sendpatchset:
>>
>>   http://www.speakeasy.org/~pj99/sgi/sendpatchset

[...]

>   Thank you for your help. But my problem is that I can only access 80
> and 443 ports behind the company firewall :(. So I guess that doesn't
> work for me.

Ask the admin. Most probably he can grant you an account so you can use
the internal email server.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
