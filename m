Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271414AbTGQNUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 09:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271419AbTGQNUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 09:20:37 -0400
Received: from ns.tasking.nl ([195.193.207.2]:51473 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S271414AbTGQNUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 09:20:36 -0400
Message-ID: <3F16A5F7.2090307@_netscape_._net_>
Date: Thu, 17 Jul 2003 15:34:47 +0200
From: David Zaffiro <davzaffiro@tasking.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021220 Debian/1.2.1-3
X-Accept-Language: nl, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: waltabbyh@comcast.net
Subject: [Fwd: Re: [PATCH] pdcraid and weird IDE geometry]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Zaffiro wrote:
<snip>
> ... I assume this was intended: To round the capacity value to the next multiple of (head * start),
> and then do a minus sect...

Of course, I meant "previous multiple of (head * sect)" here...

