Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTABJaN>; Thu, 2 Jan 2003 04:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbTABJaN>; Thu, 2 Jan 2003 04:30:13 -0500
Received: from are.twiddle.net ([64.81.246.98]:35459 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265608AbTABJaM>;
	Thu, 2 Jan 2003 04:30:12 -0500
Date: Thu, 2 Jan 2003 01:37:41 -0800
From: Richard Henderson <rth@twiddle.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com, ak@suse.de, paulus@samba.org,
       rmk@arm.linux.org.uk
Subject: Re: [PATCH] Modules 3/3: Sort sections
Message-ID: <20030102013741.A26904@twiddle.net>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	"David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	schwidefsky@de.ibm.com, ak@suse.de, paulus@samba.org,
	rmk@arm.linux.org.uk
References: <20030102030044.D066C2C05E@lists.samba.org> <20030101205404.B30272@twiddle.net> <20030101.205003.37279830.davem@redhat.com> <20030101205836.A30574@twiddle.net> <1041500184.1308.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1041500184.1308.0.camel@laptop.fenrus.com>; from arjanv@redhat.com on Thu, Jan 02, 2003 at 10:36:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 10:36:24AM +0100, Arjan van de Ven wrote:
> > Obviously.  Perhaps the question was worded badly.  Instead read
> > it as "Why don't we force this to be called .init.foo instead?"
> 
> -ffunction-sections ?

You've lost me.  What has this got to do with anything?


r~
