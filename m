Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313152AbSC1NVJ>; Thu, 28 Mar 2002 08:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313149AbSC1NVA>; Thu, 28 Mar 2002 08:21:00 -0500
Received: from zork.zork.net ([66.92.188.166]:51464 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S313148AbSC1NUk>;
	Thu, 28 Mar 2002 08:20:40 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ssh won't work from initial ram disk in 2.4.18
In-Reply-To: <20020328124257.99FD54FF@merlin.webofficenow.com>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Message-Flag: Message text advisory: DISCLOSURE OF TRADE SECRET(S),
 HACKING
X-Mailer: Norman
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 28 Mar 2002 13:20:39 +0000
Message-ID: <6uadssbzh4.fsf@zork.zork.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.1
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Rob Landley quotation:

> If this is an ssh problem I'll be happy to go bug those guys, but
> why would it be different from initrd than from an actual mounted
> partition?  (Permissions are the same, I checked.)

Have you tried running ssh with the -v switch?  That will dump a bunch
of debug info that's often very helpful with investigating problems
such as these.

-- 
 /////////////////  |                  | The spark of a pin
<sneakums@zork.net> |  (require 'gnu)  | dropping, falling feather-like.
 \\\\\\\\\\\\\\\\\  |                  | There is too much noise.
