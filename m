Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWJXIQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWJXIQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWJXIQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:16:27 -0400
Received: from [87.201.200.205] ([87.201.200.205]:40667 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S932433AbWJXINs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:13:48 -0400
Message-ID: <453DCB33.3060607@0Bits.COM>
Date: Tue, 24 Oct 2006 12:13:39 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Thunderbird 3.0a1 (X11/20061017)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi
Subject: [Fwd: Re: More uml build failures on 2.16.19-rc3 and 2.6.18.1]
Content-Type: multipart/mixed;
 boundary="------------090905060701080105030704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090905060701080105030704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Yup, did do 'make mrproper'. config attached.

Cheers
M

-------- Original Message --------
Subject: Re: More uml build failures on 2.16.19-rc3 and 2.6.18.1
Date: Tue, 24 Oct 2006 10:41:09 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Mitch <Mitch@0bits.com>
CC: linux-kernel@vger.kernel.org
References: <453DC147.2020508@0Bits.COM>

On 10/24/06, Mitch <Mitch@0bits.com> wrote:
> I'm still having build failures on 2.6.18.1 and even the latest -rc3

Did you remember to do make mrproper? If yes, can we have your .config, 
please.

--------------090905060701080105030704
Content-Type: application/x-gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
kjyTeUZKI7oPAqA1i9wYzKcm4n9hCAuZoTAAAA==
--------------090905060701080105030704--
