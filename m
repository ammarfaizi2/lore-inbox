Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756883AbWKWIby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883AbWKWIby (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757222AbWKWIby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:31:54 -0500
Received: from main.gmane.org ([80.91.229.2]:56217 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1756883AbWKWIbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:31:53 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: nfs3: possible recursive locking (Re: BUG: soft lockup detected on CPU#0! (2.6.18.2))
Date: Thu, 23 Nov 2006 08:31:45 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrneman7h.1er.olecom@deen.upol.cz.local>
References: <867ixyvum6.fsf@gere.msconsult.dk> <slrnelofru.7lr.olecom@flower.upol.cz> <86odr6f55x.fsf@gere.msconsult.dk> <86ac2jekn2.fsf@sif.msconsult.dk> <20061122141233.GA2225@flower.upol.cz> <86odqzbcmy.fsf@sif.msconsult.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.180.30
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, rasmus@msconsult.dk
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-22, Rasmus Bøg Hansen wrote:
[]
>> Did this like "my server froze. It was entirely dead and had to be power
>> cycled."?
>
> Sorry, I forgot. No it didn't freeze, it is still gladly running as if
> nothing happened.

If something really bad will happen with nfsd, try to find somebody in
MAINTAINERS file to Cc to.
____

