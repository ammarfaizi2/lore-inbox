Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267870AbTCBTBL>; Sun, 2 Mar 2003 14:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269276AbTCBTBL>; Sun, 2 Mar 2003 14:01:11 -0500
Received: from imap.gmx.net ([213.165.64.20]:42874 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267870AbTCBTBK>;
	Sun, 2 Mar 2003 14:01:10 -0500
Date: Sun, 2 Mar 2003 20:11:32 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Brad Laue <brad@brad-x.com>, linux-kernel@vger.kernel.org
Subject: Re: Cisco Aironet 340 oops with 2.4.20
Message-Id: <20030302201132.30572fbc.gigerstyle@gmx.ch>
In-Reply-To: <3E6238EE.7050802@brad-x.com>
References: <Pine.LNX.4.44.0303022210400.6149-100000@blackbird.intercode.com.au>
	<3E6238EE.7050802@brad-x.com>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Mar 2003 12:01:34 -0500
Brad Laue <brad@brad-x.com> wrote:

> James Morris wrote:
> 
> >The latter two are still happening with a tainted kernel.  Are you able to 
> >generate the crash if these modules have never been loaded?
> >
> >
> >- James
> >  
> >
> I'm not sure I follow - the NVdriver module had not been loaded at all 
> for the other two. How is the kernel tainted?

What he meant is that you still have some modules loaded which arent't GPL'd licensed like the nvidia module. If you are unsure, please mail the ouptut of lsmod...
Anyway, I think it's not the problem of these modules. The airo module sucks:-) But I think Javier and Benjamin will help us to solve the problem..

> 
>  Brad
> 
> -- 
> // -- http://www.BRAD-X.com/ -- //
> 
> 
