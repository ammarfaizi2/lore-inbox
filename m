Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262136AbSJJTfk>; Thu, 10 Oct 2002 15:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262143AbSJJTfj>; Thu, 10 Oct 2002 15:35:39 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:51604 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S262136AbSJJTfj>;
	Thu, 10 Oct 2002 15:35:39 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Arjan van de Ven <arjanv@fenrus.demon.nl>
Date: Thu, 10 Oct 2002 21:41:00 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
Cc: hch@infradead.org, linux-kernel@vger.kernel.org,
       LiS <linux-streams@gsyc.escet.urjc.es>, Dave Miller <davem@redhat.com>,
       bidulock@openss7.org, dave@gcom.com
X-mailer: Pegasus Mail v3.50
Message-ID: <43B789B00E8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Oct 02 at 21:33, Arjan van de Ven wrote:
> On Thu, 2002-10-10 at 21:07, David Grothe wrote:
> 
> > LiS is LGPL.  Would it work if the exported symbol was GPL only?
> 
> since LiS becomes GPL when you link it into the kernel with insmod,
> that's not a problem ;)

Only problem is that modutils do not know about LGPL, you must use
"GPL with additional rights" in source (at least Debian's 2.4.19-3),
and "GPL with additional rights" might be too ambiguous for authors.

                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
