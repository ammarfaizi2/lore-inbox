Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbVKHSES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbVKHSES (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbVKHSES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:04:18 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:40083 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1030272AbVKHSER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:04:17 -0500
In-Reply-To: <Pine.LNX.4.61.0511081252370.4476@chaos.analogic.com>
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com> <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net> <Pine.LNX.4.61.0511081252370.4476@chaos.analogic.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C4B3B544-72C1-42AC-B52D-7E39935E8278@comcast.net>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: Compatible fstat()
Date: Tue, 8 Nov 2005 13:04:11 -0500
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 8, 2005, at 12:53 PM, linux-os ((Dick Johnson)) wrote:
>>
>
> I'll see if it works on my Sun. Thanks.
>

Sun? ioctls being what they are it most likely won't work. Since  
there doesn't seem to be a portable way of doing this my response was  
linux-centric. (I know at least fstat doesn't give what you are  
looking for on Linux and *BSD)

Parag
