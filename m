Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSG2JZj>; Mon, 29 Jul 2002 05:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSG2JZj>; Mon, 29 Jul 2002 05:25:39 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:10746 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S314085AbSG2JZi>; Mon, 29 Jul 2002 05:25:38 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1027680453.13428.35.camel@irongate.swansea.linux.org.uk> 
References: <1027680453.13428.35.camel@irongate.swansea.linux.org.uk>  <3D4078C7.4010304@linux.org> <11261.1027674190@redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Weber <john.weber@linux.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux PCMCIA 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Jul 2002 10:28:41 +0100
Message-ID: <10045.1027934921@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
> On Fri, 2002-07-26 at 10:03, David Woodhouse wrote:
> > Unfortunately the plan is all we have at the moment, other than a few 
> > hundred lines of untested core device/driver registration code and
> > untested CIS-parsing code. I threw that together hoping it would work like
> > stone soup -- but it hasn't worked yet, so it's going to have to wait till 
> > I have more time to play.

> Maybe if you tell people where your soup pot is 8) 

I was sort of hoping to get it in slightly better shape before mentioning 
it to the great unwashed, but who cares...

	cvs -d :ext:anoncvs@cvs.infradead.org login 
		(password anoncvs)
	cvs -d :ext:anoncvs@cvs.infradead.org co pcmcia

	http://lists.infradead.org/mailman/listinfo/linux-pcmcia
	http://lists.infradead.org/mailman/listinfo/linux-pcmcia-cvs

--
dwmw2


