Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbUBNEvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 23:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUBNEvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 23:51:38 -0500
Received: from smtp2.fuse.net ([216.68.8.172]:11925 "EHLO smtp2.fuse.net")
	by vger.kernel.org with ESMTP id S264586AbUBNEvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 23:51:37 -0500
In-Reply-To: <20040214044656.GI31199@mail.shareable.org>
References: <200402120122.06362.ross@datscreative.com.au> <402CB24E.3070105@gmx.de> <200402140041.17584.ross@datscreative.com.au> <200402141124.50880.ross@datscreative.com.au> <20040214044656.GI31199@mail.shareable.org>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6EFBED2E-5EA9-11D8-AC2C-000393A6D2F2@physics.uc.edu>
Content-Transfer-Encoding: 7bit
Cc: gcc@gcc.gnu.org, Ross Dickson <ross@datscreative.com.au>,
       Andrew Pinski <pinskia@physics.uc.edu>, linux-kernel@vger.kernel.org
From: Andrew Pinski <pinskia@physics.uc.edu>
Subject: Re: GCC feature request: warn on "if (function_name)"
Date: Fri, 13 Feb 2004 20:51:21 -0800
To: Jamie Lokier <jamie@shareable.org>
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 13, 2004, at 20:46, Jamie Lokier wrote:
>
> Perhaps a later GCC than 3.2.2 already has this test; if someone is
> able to check, that would be nice.

Yes, 3.4.0 does have this check.
t.c:5: warning: the address of `i', will always evaluate as `true'

Thanks,
Andrew Pinski

