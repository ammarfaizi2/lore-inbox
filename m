Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272773AbRJJBfx>; Tue, 9 Oct 2001 21:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273108AbRJJBfn>; Tue, 9 Oct 2001 21:35:43 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:5189 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S272773AbRJJBff>; Tue, 9 Oct 2001 21:35:35 -0400
Date: Tue, 9 Oct 2001 20:35:56 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: sethg@eng.sun.com
cc: Robert Vojta <vojta@pharocom.net>, seth goldberg <seth.goldberg@sun.com>,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: sis900 does not work in 2.4.10
In-Reply-To: <Pine.LNX.4.33.0110091543410.3118-100000@bergsoft.eng.sun.com>
Message-ID: <Pine.LNX.3.96.1011009203409.702C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001 sethg@eng.sun.com wrote:
>   Installing the 2.4.10-ac10 patch fixed this [sis900] problem 100%.
>   Thanks ver much for the help.

Note that the only sis900 change in 2.4.10-ac10 is the addition of a
line MODULE_LICENSE("GPL").  Either your compiler is malfunctioning or
some other bug is/was affecting you.

	Jeff




