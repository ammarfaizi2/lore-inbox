Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbUJ1Eih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUJ1Eih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 00:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbUJ1Eif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 00:38:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6557 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262766AbUJ1Eid
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 00:38:33 -0400
Message-ID: <418077BC.10806@pobox.com>
Date: Thu, 28 Oct 2004 00:38:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Terje Kvernes <terjekv@math.uio.no>
CC: Seiichi Nakashima <nakasima@kumin.ne.jp>, linux-kernel@vger.kernel.org,
       Netdev <netdev@oss.sgi.com>
Subject: Re: linux-2.6.9 eepro100 warning
References: <200410232313.AA00003@prism.kumin.ne.jp>	<417C9A4E.3030909@pobox.com> <wxxr7nma801.fsf@nommo.uio.no>
In-Reply-To: <wxxr7nma801.fsf@nommo.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Kvernes wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
>   [ ... ]
> 
> 
>>Note that eepro100 driver will be deleted soon.
> 
> 
>   we have several systems where e100 produces netdev watchdog errors,
>   while eepro100 works without problems.  I can understand the desire
>   to migrate, but what timeframe are we looking at?  roughly
>   translated, when do I _have_ to start help debugging the e100
>   driver?  ;-)
> 
>   I can do another attempt at rolling out the e100 driver, see what
>   breaks, and try to report it around 2.6.1[01] or something like that
>   if that helps?


If there are e100 problems, report them to the maintainers so we can get 
them resolved ASAP...

INTEL PRO/100 ETHERNET SUPPORT
P:      John Ronciak
M:      john.ronciak@intel.com
P:      Ganesh Venkatesan
M:      ganesh.venkatesan@intel.com
P:      Scott Feldman
M:      scott.feldman@intel.com
W:      http://sourceforge.net/projects/e1000/
S:      Supported

(and of course netdev@oss.sgi.com as well)

