Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264330AbUFKTwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbUFKTwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 15:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbUFKTwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 15:52:54 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:31998 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264330AbUFKTwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 15:52:53 -0400
Message-ID: <40CA0D91.9010502@nortelnetworks.com>
Date: Fri, 11 Jun 2004 15:52:49 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: bj0rn@blox.se
Subject: Re: kernel/module compiler version problem
References: <20040611193136.GA21058@kroah.com>
In-Reply-To: <20040611193136.GA21058@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Jun 11, 2004 at 03:16:00PM -0400, Chris Friesen wrote:
>  > I'm running 2.4.22, build with gcc 3.3.1, modutils 2.4.22.
>  >
>  > I have an ATM driver that is shipped with a binary blob and a source 
> code
>  > shim.
> 
> Go ask the people who provided you the binary blob, sorry but no one
> here can help you with this issue.

Heh...how did I know that was coming...

I realize I can't reasonably ask here about problems if things blow up.  I was 
actually more interested in exactly what the conflicts were between a binary 
chunk compiled with gcc2 linked with source compiled with gcc3 and loaded into a 
kernel compiled with gcc3.

I had hoped some of the modutils people might respond, since they obviously know 
of some issues.

Chris
