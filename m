Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263196AbREaTtK>; Thu, 31 May 2001 15:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbREaTtB>; Thu, 31 May 2001 15:49:01 -0400
Received: from t2.redhat.com ([199.183.24.243]:54778 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S263189AbREaTsq>; Thu, 31 May 2001 15:48:46 -0400
Message-ID: <3B16A01C.ED5C6CCB@redhat.com>
Date: Thu, 31 May 2001 20:48:44 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Configure.help is complete
In-Reply-To: <20010531132454.A8361@thyrsus.com> <20010531201349.B1877@dardhal.mired.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

José Luis Domingo López wrote:
> 
> On Thursday, 31 May 2001, at 13:24:54 -0400,
> Eric S. Raymond wrote:
> 
> > It gives me great pleasure to announce that the Configure.help master
> > file is now complete with respect to 2.4.5.  Every single one of the
> > 2699 configuration symbols actually used in the 2.4.5 codebase's C
> > source files or Makefiles now has an entry in Configure.help.
> >
> Would it be great to have a similar documentation for those hundreds of
> "files" under /proc ?. Something like:

<snip>
Powertweak has descriptions for most of the usable /proc entries,
in XML format but the descriptions are easily extractable. Maybe it's 
a good idea to make the powertweak set complete instead / share the set
with the kernel docs.

Greetings,
    Arjan van de Ven
