Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVBRTdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVBRTdq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 14:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVBRTdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 14:33:45 -0500
Received: from simmts12.bellnexxia.net ([206.47.199.141]:33252 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261452AbVBRTdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 14:33:44 -0500
Message-ID: <3369.10.10.10.24.1108755080.squirrel@linux1>
In-Reply-To: <d120d50005021811263c40f683@mail.gmail.com>
References: <seanlkml@sympatico.ca><4912.10.10.10.24.1108675441.squirrel@linux1><200502180142.j1I1gJXC007648@laptop11.inf.utfsm.cl><1451.10.10.10.24.1108713140.squirrel@linux1><20050218162729.GA5839@thunk.org><4075.10.10.10.24.1108751663.squirrel@linux1>
    <d120d50005021811263c40f683@mail.gmail.com>
Date: Fri, 18 Feb 2005 14:31:20 -0500 (EST)
Subject: Re: [BK] upgrade will be needed
From: "Sean" <seanlkml@sympatico.ca>
To: dtor_core@ameritech.net
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Chris Friesen" <cfriesen@nortel.com>, "d.c" <aradorlinux@yahoo.es>,
       cs@tequila.co.jp, galibert@pobox.com, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-7
X-Mailer: SquirrelMail/1.4.3a-7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, February 18, 2005 2:26 pm, Dmitry Torokhov said:

> What is bk2cvs gateway that is maintained by Larry then? Just call it
> your "head" that Linus feeds from his BK repository and you are all
> set.
>
> I can see  that Roman and Stellian want something different, but we
> alerady have what you have just described.
>

Bitkeeper isn't motivated to raise the bar in terms of implementation, nor
is cvs the best choice in terms of which free tool to use.   Once a free
SCM is actually used at the head, there are opportunities to implement
updating too, not just pulling.

Cheers,
Sean


