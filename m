Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVBRTwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVBRTwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 14:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVBRTwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 14:52:34 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:5740 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261468AbVBRTtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 14:49:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gQKnFIGwalKmLrOfF51uuN6q0AvAqZFNM2URG0kA54t5E60IKg0E2VKNe5+8LrXwRd6zET+NbnHIjuo0ioB1p+qSPIlJmE/4uddVtvmHbLq+oLKDR4oF8gDe1f9goMNf3Giwk25LPIAiq8UDG2RHRS/AuT8fdor3InmFIWy1v7U=
Message-ID: <d120d5000502181149670d27c0@mail.gmail.com>
Date: Fri, 18 Feb 2005 14:49:28 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Sean <seanlkml@sympatico.ca>
Subject: Re: [BK] upgrade will be needed
Cc: "Theodore Ts'o" <tytso@mit.edu>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Chris Friesen <cfriesen@nortel.com>, "d.c" <aradorlinux@yahoo.es>,
       cs@tequila.co.jp, galibert@pobox.com, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <3369.10.10.10.24.1108755080.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <seanlkml@sympatico.ca>
	 <4912.10.10.10.24.1108675441.squirrel@linux1>
	 <200502180142.j1I1gJXC007648@laptop11.inf.utfsm.cl>
	 <1451.10.10.10.24.1108713140.squirrel@linux1>
	 <20050218162729.GA5839@thunk.org>
	 <4075.10.10.10.24.1108751663.squirrel@linux1>
	 <d120d50005021811263c40f683@mail.gmail.com>
	 <3369.10.10.10.24.1108755080.squirrel@linux1>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 14:31:20 -0500 (EST), Sean <seanlkml@sympatico.ca> wrote:
> On Fri, February 18, 2005 2:26 pm, Dmitry Torokhov said:
> 
> > What is bk2cvs gateway that is maintained by Larry then? Just call it
> > your "head" that Linus feeds from his BK repository and you are all
> > set.
> >
> > I can see  that Roman and Stellian want something different, but we
> > alerady have what you have just described.
> >
> 
> Bitkeeper isn't motivated to raise the bar in terms of implementation, nor
> is cvs the best choice in terms of which free tool to use.

You from cvs you can import into other SCM of your choise.

>  Once a free
> SCM is actually used at the head, there are opportunities to implement
> updating too, not just pulling.

Heh, you don't get to update the master repository even if you are
using BK.  And you are free to update your local tree with
CVS/SVN/whatever. So I am not sure why you trying this argument.

-- 
Dmitry
