Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbUCTBb3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 20:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbUCTBb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 20:31:29 -0500
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:7674 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263196AbUCTBb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 20:31:26 -0500
Message-ID: <405B9FD6.7050100@jguk.org>
Date: Sat, 20 Mar 2004 01:35:18 +0000
From: "J. Grant" <jg-lists@jguk.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030824
X-Accept-Language: en-gb
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Linux-Kernel ML <linux-kernel@vger.kernel.org>, tech_support2@sdesigns.com
Subject: Re: Rimax Linux DVD/DivX player firwmare source code
References: <405A0EB2.40105@jguk.org> <20040318224953.GA14730@codepoet.org>
In-Reply-To: <20040318224953.GA14730@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Mar 2004 01:31:26.0108 (UTC) FILETIME=[0F8DE5C0:01C40E1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erik,

Thanks for the info.

I wonder if there is anyone at OSDN (I think these are the main managers
of Linux?) who we could contact who would be able to encourage these
companies to provide the source code to licensee's? (and comply with the
licence in general etc).

The firmware I have seems to be based on linux v2.4.17-uc0, with a
EM850908/EM85xx0912 chipset support.  Compiled by someone with username
lizq@SRCSRV.  The two modules are a front panel/remote control module,
and "KHWL.O" by Emmanuel Michon and Fabrice Gautier of Sigma Designs.

Kind regards

JG



on the 18/03/04 22:49, Erik Andersen wrote:
> On Thu Mar 18, 2004 at 09:03:46PM +0000, J. Grant wrote:
>>     ./BIN:
>>     total 340
>>     -rwx------    1   53708 Dec 23 12:08 BUSYBOX*
>>     -rwx------    1   279060 Dec 23 12:08 INIT*
> 
> Sigh.  Yet another one.  I have a list of with some of them here:
>     http://www.busybox.net/shame.html
> though undoubtedly there are others...  Sigma Designs EM8500
> based DVD players are everyone, and I am not aware of a simgle
> one that is in compliance with the GPL. :-(
> 
> The sigma designs reference system source code is here
> 	http://www.uclinux.org/pub/uClinux/ports/arm/EM8500/
> though it is difficult to know if this source is even remotely
> relevant to your particular product.
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> 



