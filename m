Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269143AbUIXUrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269143AbUIXUrL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269142AbUIXUrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:47:06 -0400
Received: from smtp.knology.net ([24.214.63.101]:45756 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S269121AbUIXUoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:44:09 -0400
Message-ID: <4154871D.2090209@coyotegulch.com>
Date: Fri, 24 Sep 2004 16:44:13 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean-Luc Cooke <jlcooke@certainkey.com>
CC: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
References: <20040923234340.GF28317@certainkey.com> <20040924043851.GA3611@thunk.org> <20040924125457.GO28317@certainkey.com> <20040924174301.GB20320@thunk.org> <20040924175929.GU28317@certainkey.com>
In-Reply-To: <20040924175929.GU28317@certainkey.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Luc Cooke wrote:
> If I submitted a patch that gave users the choice of swapping my Fortuna for
> the current /dev/random, would you be cool with that then?

I would certainly appreciate this option, given that my customers often 
have very different ideas of what they need. I don't see how it hurts 
the kernel to have a choice for /dev/random.

-- 
Scott Robert Ladd
site: http://www.coyotegulch.com
blog: http://chaoticcoyote.blogspot.com
