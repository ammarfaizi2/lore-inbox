Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVBCQtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVBCQtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbVBCQtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:49:19 -0500
Received: from terminus.zytor.com ([209.128.68.124]:9143 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262747AbVBCQp7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:45:59 -0500
Message-ID: <42025540.4070600@zytor.com>
Date: Thu, 03 Feb 2005 08:45:52 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
References: <20050202155403.GE3117@crusoe.alcove-fr> <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com>
In-Reply-To: <20050203033459.GA29409@bitmover.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> 
> As Peter said, we do exports from Linus' tree every 24 hours.  I can
> think of two things that we could do which might be useful to the non BK
> users: export more frequently (pretty questionable in my mind but it's
> no big deal to bump it up to twice or whatever) and/or export other trees
> (far more interesting in my mind).
> 

I think exporting every 6 hours might be a good place.  That avoids the 
"can't get it until tomorrow" effect.

As far as exporting other trees, I'll leave it up to whomever wants it 
to say which, but we certainly can host the uplink result.

	-hpa
