Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131149AbRAAArU>; Sun, 31 Dec 2000 19:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131179AbRAAArK>; Sun, 31 Dec 2000 19:47:10 -0500
Received: from mercury.nildram.co.uk ([195.112.4.37]:53776 "EHLO
	mercury.nildram.co.uk") by vger.kernel.org with ESMTP
	id <S131149AbRAAAqx>; Sun, 31 Dec 2000 19:46:53 -0500
Message-ID: <3A4FCC54.14F38593@magenta-netlogic.com>
Date: Mon, 01 Jan 2001 00:16:20 +0000
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tony Spinillo <tspin@epix.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: TEST13-PRE7 - Nvidia Kernel Module Compile Problem
In-Reply-To: <3A4E3D6D.4D64E13@epix.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Spinillo wrote:
> 
> The nvidia kernel module (from www.nvidia.com) has compiled and loaded
> correctly with all test13-pre series up to pre6. I just tried to
> compile and load under pre7.

I'm intrigued... how did you resolve the 'mem_map_inc_count' and
'mem_map_dec_count',
'put_module_symbol' and 'get_module_symbol' references?

It's only of academic interest for me now as I've ditched the nvidia -
not worth the hassle.

Amusingly, We're breaking the EULA even by reading the supplied source
code...

Tony

-- 
Can't think of a decent signature...

tmh@magenta-netlogic.com		http://www.nothing-on.tv
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
