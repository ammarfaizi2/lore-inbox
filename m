Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVIJKOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVIJKOz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 06:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVIJKOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 06:14:55 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:46249 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750741AbVIJKOz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 06:14:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FEmrTfAVIXcN8J0if7EdrxqAF/ukm2POEIJjUkcxfNoDhL/d7x7G1ca1ge6RojS85TGg5dK/KSfTPPiFmX5dZ1CBZ9AbnSCPp5LAsqxGMP492r3gHH8tktjYgoZoCaplWGByZXGS9vDhNH3JuzLtOYkvdXl+FY4wiFjWfrTBMmc=
Message-ID: <84144f0205091003147c15711@mail.gmail.com>
Date: Sat, 10 Sep 2005 13:14:53 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
Reply-To: Pekka Enberg <penberg@cs.helsinki.fi>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: List of things requested by lkml for reiser4 inclusion (to review)
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <4321C806.60404@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509091817.39726.zam@namesys.com> <4321C806.60404@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/05, Hans Reiser <reiser@namesys.com> wrote:
> 8.  Remove all assertions because they clutter the code and make it hard to read

I don't think anyone suggested to remove _all_ assertions. I did,
however, suggested to tone down some of the ones that seem overly
defensive and clutter the code. If that is unacceptable to you and
maintainers can live with that then I have no problem with it either.

                                        Pekka
