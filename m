Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbRAaWkA>; Wed, 31 Jan 2001 17:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129065AbRAaWjl>; Wed, 31 Jan 2001 17:39:41 -0500
Received: from adsl-216-102-91-127.dsl.snfc21.pacbell.net ([216.102.91.127]:31985
	"EHLO champ.drew.net") by vger.kernel.org with ESMTP
	id <S129054AbRAaWjd>; Wed, 31 Jan 2001 17:39:33 -0500
From: Drew Bertola <drew@drewb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14968.37921.303952.683312@champ.drew.net>
Date: Wed, 31 Jan 2001 22:39:29 +0000 ()
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Pavel Machek'" <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: RE: ACPI fix + comments
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE61D@orsmsx35.jf.intel.com>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE61D@orsmsx35.jf.intel.com>
X-Mailer: VM 6.75 under Emacs 19.34.1
Reply-To: drew@drewb.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew writes:
> This is a temporary interface, just to see if we're returning values
> properly. Your points below are well taken. People really care about
> minutes/percentage remaining. In your opinion should we just report that
> through /proc or should we keep the data low-level like it is now, and have
> a user app do the math, or what?

I'd be happy with the way it is now if I could understand the data.
Is there any documentation available to help me convert it?

-- 
Drew Bertola  | Send a text message to my pager or cell ... 
              |   http://jpager.com/Drew

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
