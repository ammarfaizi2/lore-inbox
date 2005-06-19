Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVFSBtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVFSBtL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 21:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVFSBtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 21:49:11 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:30443 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261233AbVFSBtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 21:49:07 -0400
From: David Lang <david.lang@digitalinsight.com>
To: aq <aquynh@gmail.com>
Cc: linux-kernel@vger.kernel.org
Date: Sat, 18 Jun 2005 18:48:59 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Linux 2.6.12
In-Reply-To: <9cde8bff0506181839d41aab3@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0506181847550.11617@qynat.qvtvafvgr.pbz>
References: <200506182005.28254.nick@linicks.net><9a8748490506181233675f2fd5@mail.gmail.com>
 <9cde8bff0506181839d41aab3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2005, aq wrote:

> the version number is a little bit confused here: if I want to upgrade
> from for example 2.6.11.5 to 2.6.12, which patch should I get?

you reverse the 2.6.11 -> 2.6.11.5 patch to get back to a vinilla 2.6.11
then you apply the 2.6.11->2.6.12 patch.

David Lang

> anybody knows if Matt will upgrade his ketchup for the new versioning
> system soon? otherwise, I might spend some time to hack it up.
>
> regards,
> aq
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
