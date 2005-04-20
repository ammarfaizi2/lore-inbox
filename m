Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVDTV6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVDTV6t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 17:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVDTV6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 17:58:49 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:3332 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S261828AbVDTV6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 17:58:37 -0400
Message-ID: <4266C0C3.7070002@lougher.demon.co.uk>
Date: Wed, 20 Apr 2005 21:51:15 +0100
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove some usesless casts
References: <20050420065500.GA24213@wohnheim.fh-wedel.de> <4266732A.6050508@lougher.demon.co.uk> <20050420213336.GA22421@wohnheim.fh-wedel.de>
In-Reply-To: <20050420213336.GA22421@wohnheim.fh-wedel.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

> Your definition of _unnecessary_ casts may differ from mine.
> Basically, every cast is unnecessary, except for maybe one or two - if
> that many.
> 

Well we agree to differ then.  In my experience casts are sometimes 
necessary, and are often less clumsy than the alternatives (such as 
unions).  This is probably a generational thing, the fashion today is to 
make languages much more strongly typechecked than before.


