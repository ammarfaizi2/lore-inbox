Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263740AbSJJU1Q>; Thu, 10 Oct 2002 16:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263969AbSJJU0U>; Thu, 10 Oct 2002 16:26:20 -0400
Received: from email.gcom.com ([206.221.230.194]:27327 "EHLO gcom.com")
	by vger.kernel.org with ESMTP id <S263758AbSJJU0N>;
	Thu, 10 Oct 2002 16:26:13 -0400
Message-Id: <5.1.0.14.2.20021010152900.02699598@localhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 10 Oct 2002 15:31:19 -0500
To: Christoph Hellwig <hch@infradead.org>
From: David Grothe <dave@gcom.com>
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       LiS <linux-streams@gsyc.escet.urjc.es>, davem@redhat.com,
       bidulock@openss7.org
In-Reply-To: <5.1.0.14.2.20021010140426.0271c6a0@localhost>
References: <20021010182740.A23908@infradead.org>
 <5.1.0.14.2.20021010115616.04a0de70@localhost>
 <4386E3211F1@vcnet.vc.cvut.cz>
 <5.1.0.14.2.20021010115616.04a0de70@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys, I think we are closing in on it.

I ran the patch through Lindent.  I moved the exported symbol to sys.c and 
made it GPL only.  I tested it on 2.4.19.

If we could agree on a header file location for the prototype, or not to 
have a prototype, I could cook up another candidate for "final" in short order.

Thanks for all the suggestions,
Dave

