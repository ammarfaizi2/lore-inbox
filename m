Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287535AbSANQMh>; Mon, 14 Jan 2002 11:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287539AbSANQM1>; Mon, 14 Jan 2002 11:12:27 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:31775 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287535AbSANQMR>; Mon, 14 Jan 2002 11:12:17 -0500
Message-ID: <3C430322.D28AB30C@redhat.com>
Date: Mon, 14 Jan 2002 16:11:14 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: FC & MULTIPATH !? (any hope?)
In-Reply-To: <200201141524.g0EFOqj09542@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> 
> > > is there any hope of working combination of MULTIPATH with FC !?
> >
> > Yes. QLogic's newest 2200 HBA can do that. I don't know whether that is a
> > possible solution for your problem though.
> 
> To clarify: This solution is being pushed by IBM.  Unless you have a FASt
> array, you may not get help making it work from either IBM or Qlogic.  You
> also need the 5.x qlogic driver which you can download from the IBM website
> (or from SuSE 7.3).

the 5.x qlogic driver "needs some work" to not function properly though, 
unfortionatly. But that's a work in progress.....
