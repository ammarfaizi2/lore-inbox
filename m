Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276671AbRJPU27>; Tue, 16 Oct 2001 16:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276675AbRJPU2t>; Tue, 16 Oct 2001 16:28:49 -0400
Received: from fe100.worldonline.dk ([212.54.64.211]:16145 "HELO
	fe100.worldonline.dk") by vger.kernel.org with SMTP
	id <S276671AbRJPU2f>; Tue, 16 Oct 2001 16:28:35 -0400
Message-ID: <3BCC9887.9664650F@eisenstein.dk>
Date: Tue, 16 Oct 2001 22:28:55 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@ns.caldera.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] various minor cleanups against 2.4.13-pre3 - comments 
 requested
In-Reply-To: <200110161959.f9GJx8T03152@ns.caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> In article <3BCC8C88.58BBCC39@eisenstein.dk> you wrote:
> > kernel/exec_domain.c :
<snip>
> > length). So I moved the function definitions
> >         onto a single line.
> 
> NO.  This file is maintained and that style is intentional.
> (BTW, you could compare it to output of scripts/Lindent..)

Ok. I had a feeling that doing coding-style changes would probably not
be a good idea - thank you for the feedback. I'll take a look at
scripts/Lindent.

> 
> > kernel/exec_domain.c : get_exec_domain_list()
> 
> Looks sane to me.
> 

Ok, great, I'll keep that bit on my "things that could possibly turn
into a real patch someday" list :)

- Jesper Juhl
