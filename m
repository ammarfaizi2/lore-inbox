Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUDBJL5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 04:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263372AbUDBJL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 04:11:57 -0500
Received: from gate.corvil.net ([213.94.219.177]:43016 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S263370AbUDBJLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 04:11:55 -0500
Message-ID: <406D2CD6.50609@draigBrady.com>
Date: Fri, 02 Apr 2004 10:05:26 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
CC: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       ak@suse.de
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
In-Reply-To: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Weigand wrote:
> Hello,
> 
> I'm seeing a race condition on Linux 2.6 that rather reproducibly
> causes GCC bootstrap failures on current mainline.

Ho hum.
I knew this was going to cause problems:
http://www.ussg.iu.edu/hypermail/linux/kernel/0110.1/0017.html

Pádraig.
