Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132513AbRDNSOY>; Sat, 14 Apr 2001 14:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132514AbRDNSOO>; Sat, 14 Apr 2001 14:14:14 -0400
Received: from napalm.go.cz ([212.24.148.98]:33802 "EHLO napalm.go.cz")
	by vger.kernel.org with ESMTP id <S132513AbRDNSOI>;
	Sat, 14 Apr 2001 14:14:08 -0400
Date: Sat, 14 Apr 2001 20:12:50 +0200
From: Jan Dvorak <johnydog@go.cz>
To: Guest section DW <dwguest@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
Message-ID: <20010414201250.A7260@napalm.go.cz>
Mail-Followup-To: Guest section DW <dwguest@win.tue.nl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010413150219.A440@napalm.go.cz> <20010414002120.A15596@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
In-Reply-To: <20010414002120.A15596@win.tue.nl>; from dwguest@win.tue.nl on Sat, Apr 14, 2001 at 12:21:20AM +0200
Organization: (XNET.cz)
X-URL: http://doga.go.cz/
X-OS: Linux 2.4.3 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2001 at 12:21:20AM +0200, Guest section DW wrote:
> No, these codes cannot be larger than 127 today.
> You can use the utility setkeycodes to assign keycodes to these keys.
I always tought it is 8bit - more-than-128-keys keyboards exists quite long
time. 

> [One of the things for 2.5 is 15- or 31-bit keycodes.
> The 7-bits we have today do no longer suffice. I have a 132-key keyboard.]
Yes, this is necessary then. Hmm, the move to 15bits looks simple,
any ideas why this wasn't implemented before ? Yes, this isn't priority,
because it is working fine with setkeycodes, but anyway ...

Jan Dvorak <johnydog@go.cz>

