Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132691AbRDXCp2>; Mon, 23 Apr 2001 22:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132707AbRDXCpS>; Mon, 23 Apr 2001 22:45:18 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:11108 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132691AbRDXCpN>; Mon, 23 Apr 2001 22:45:13 -0400
Message-ID: <3AE4E87F.FDE83136@redhat.com>
Date: Mon, 23 Apr 2001 22:44:15 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
CC: pawel.worach@mysun.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: i810_audio broken?
In-Reply-To: <3804336226.3622638043@mysun.com> <m3n197ur5i.fsf@giants.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chmouel Boudjnah wrote:
> 
> "Pawel Worach" <pworach@mysun.com> writes:
> 
> > I was using mpg123 (xmms and c/o does exactly the same)
> > if I run it like this Moby sounds very stupid... :)
> 
> i got the same problem when using mpg123 compiled with esd on my dell
> workstation (which has a need to have set explictely to a clocking of
> 41194 via ftsodell option), compiling without esd seems fix the prob
> for me.

The latest i810 driver does away with the ftsodell option entirely and should
work on your laptop without having to do anything special.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
