Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272309AbTGYV3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272311AbTGYV3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 17:29:07 -0400
Received: from dsl093-172-075.pit1.dsl.speakeasy.net ([66.93.172.75]:60556
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S272309AbTGYV3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 17:29:05 -0400
Date: Fri, 25 Jul 2003 17:43:51 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cutting down on boot messages
Message-ID: <20030725214351.GG28205@kurtwerks.com>
References: <20030725195752.GA8107@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725195752.GA8107@middle.of.nowhere>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Jurriaan:
> If I boot my system, there are copious messages. 
> 

[...]

> Now these messages are often uninteresting - but sometimes they are.
> So just deleting them, or requiring a recompile or reboot is not good
> enough.
> Also, I noted that these messages were almost always grouped together.
> 
> Suppose these messages were removed from the normal output, but instead
> stored in a buffer in the kernel.

How about the "quiet" kernel command line parameter, which quiets
down the boot process but still stores the messages in the ring
buffer?

Kurt
-- 
Support bacteria -- it's the only culture some people have!
