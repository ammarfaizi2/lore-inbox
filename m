Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263930AbRGLNzA>; Thu, 12 Jul 2001 09:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264032AbRGLNyu>; Thu, 12 Jul 2001 09:54:50 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29073 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263930AbRGLNyi>;
	Thu, 12 Jul 2001 09:54:38 -0400
Message-ID: <3B4DAC1B.D9368E51@mandrakesoft.com>
Date: Thu, 12 Jul 2001 09:54:35 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fabbione <fabbione@fabbione.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: RFC: Remove swap file support
In-Reply-To: <3B472C06.78A9530C@mandrakesoft.com> <3B4D5158.E125A487@fabbione.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabbione wrote:
>         why you think people are still not using it????
> I still do on most of my systems...

> Jeff Garzik wrote:
> > Since you can make any file into a block device using loop,
> > is there any value to supporting swap files in 2.5?
> >
> > swap files seem like a special case that is no longer necessary...

Re-read my message.  I do not say get rid of swap files, only swap file
code.  You can use loop for swap files.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
