Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVBWQ34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVBWQ34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 11:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVBWQ34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 11:29:56 -0500
Received: from viefep12-int.chello.at ([213.46.255.25]:38429 "EHLO
	viefep12-int.chello.at") by vger.kernel.org with ESMTP
	id S261445AbVBWQ3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 11:29:54 -0500
Message-ID: <421CAF7D.9080004@vollwerbung.at>
Date: Wed, 23 Feb 2005 17:29:49 +0100
From: Nils Kalchhauser <n.kalchhauser@vollwerbung.at>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: mouse still losing sync and thus jumping around
References: <421C83A2.9040502@vollwerbung.at> <d120d50005022306177069ffbe@mail.gmail.com>
In-Reply-To: <d120d50005022306177069ffbe@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Wed, 23 Feb 2005 14:22:42 +0100, Nils Kalchhauser
> There were 2 versions of the psmouse-resend patch, the first one was
> indeed producing worse results, the second one should work better.
> Could you please try grabbing the patch against 2.6.10 from here:
> 
> http://www.geocities.com/dt_or/input/2_6_10/
> 
> and letting me know if it gives better results.

sorry for not realising that there was a newer patch. I tried that one 
now and indeed it seems a lot better. I did not have any lost sync 
message for about an hour but then the mouse started jumping again. and 
it seems to me like it is connected to disk activity... is that possible?


Nils
