Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbTKMHbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 02:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTKMHbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 02:31:12 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:6296 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261777AbTKMHbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 02:31:10 -0500
Message-ID: <3FB333B2.2090006@stesmi.com>
Date: Thu, 13 Nov 2003 08:33:06 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Some thoughts about stable kernel development
References: <m3u15de669.fsf@defiant.pm.waw.pl> <3FAE9026.60500@stesmi.com>	<m3ekwd8w2m.fsf@defiant.pm.waw.pl> <3FB25A28.1070800@stesmi.com> <m3oevh7cnu.fsf@defiant.pm.waw.pl>
In-Reply-To: <m3oevh7cnu.fsf@defiant.pm.waw.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:

> Stefan Smietanowski <stesmi@stesmi.com> writes:
> 
> 
>>The amount of mail coming to the list with FAQ like that shows that
>>no, people aren't. Many are, some aren't. Some of those end up asking
>>things that have been asked a thousand times.
> 
> 
> I've never considered asking a question, even a FAQ, bad. If many people
> ask the same question - what does it mean? For me, it just means the
> question is an important one and that the problem is not yet solved.

Asking a question is not bad, but if we can avoid making a situation
that will generate questions I would say that's a worthwhile goal.

x.y.z - if y is odd it's development, if y is even it's stable.
Easy.
z+1 is always newer than z and hence z+1 should contain a bugfix that
z might not. Also pretty simple. x.y.z+1 pre/rc q does not contain
something that x.y.z pre/rc r has is NOT easy. We both know that
me and you will have no problem whatsoever with this scheme. So it's
not about me and you. I just think it will confuse some people that's
all.

// Stefan

