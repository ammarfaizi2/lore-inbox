Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131277AbRBHVxF>; Thu, 8 Feb 2001 16:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131376AbRBHVwz>; Thu, 8 Feb 2001 16:52:55 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:14268 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131277AbRBHVww>; Thu, 8 Feb 2001 16:52:52 -0500
Message-ID: <3A8314FB.373783C0@redhat.com>
Date: Thu, 08 Feb 2001 16:51:55 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.LNX.4.21.0102081932320.685-100000@penguin.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> 
> two mistakes:
> 
> a) dledford@redhat.com, not veritas.com! (it was pine, not me -- default
> domain etc :)
> 
> b) it was ac6 which fixed it, not ac7 (but I am running ac7)
> 
> On Thu, 8 Feb 2001, Tigran Aivazian wrote:
> 
> > Doug,
> >
> > I confirm that ac7 fixed all the aic7xxx problems on my machine.

Thanks, I hoped it would ;-)  It's amazing what happens when you have a bcopy
in assembly that's missing the source address initialization :-(

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
