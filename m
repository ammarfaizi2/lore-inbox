Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277728AbRKFEIb>; Mon, 5 Nov 2001 23:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277758AbRKFEIV>; Mon, 5 Nov 2001 23:08:21 -0500
Received: from viper.haque.net ([66.88.179.82]:48802 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S277728AbRKFEIM>;
	Mon, 5 Nov 2001 23:08:12 -0500
Date: Mon, 5 Nov 2001 23:08:08 -0500
Subject: Re: kernel 2.4.14 compiling fail for loop device
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
Cc: Mike Fedyk <mfedyk@matchmail.com>, Terminator <jimmy@mtc.dhs.org>,
        linux-kernel@vger.kernel.org
To: Robert Love <rml@tech9.net>
From: "Mohammad A. Haque" <mhaque@haque.net>
In-Reply-To: <1005019360.897.2.camel@phantasy>
Message-Id: <E290D3DA-D26B-11D5-A0A2-00306569F1C6@haque.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.475)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday, November 5, 2001, at 11:02 PM, Robert Love wrote:

> On Mon, 2001-11-05 at 22:43, Mike Fedyk wrote:
>> Did anyone have this problem with pre8???
>
> Nope, it was added post-pre8 to final.  The deactivate_page function was
> removed completely.

Safe to remove those two lines from loop.c? Other calls of deactive_page 
were just removed it seemed.

--

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                                mhaque@haque.net

   "Alcohol and calculus don't mix.             Developer/Project Lead
    Don't drink and derive." --Unknown          http://wm.themes.org/
                                                batmanppc@themes.org
=====================================================================

