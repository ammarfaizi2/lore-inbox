Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293518AbSBZFBz>; Tue, 26 Feb 2002 00:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293520AbSBZFBp>; Tue, 26 Feb 2002 00:01:45 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:42418 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S293518AbSBZFBi>; Tue, 26 Feb 2002 00:01:38 -0500
Date: Mon, 25 Feb 2002 20:33:23 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in
 the	tree
Message-ID: <187757891.1014669202@[10.10.2.3]>
In-Reply-To: <E16erSe-0001Qn-00@starship.berlin>
In-Reply-To: <E16erSe-0001Qn-00@starship.berlin>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> rmap still sucks on large systems though.
>
> But this is not a fundamental issue, it's implementation.
> Whereas non-rmap will always suck on large systems, for
> fundamental reasons that are unrelated to the quality of
> the implementation.

Absolutely ... it's just not quite finished yet. I'm
convinced it'll be a major win for everyone in the end,
I just squirm a little when I see people advocating it
going into the mainline right now.

M.

