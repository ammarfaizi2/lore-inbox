Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262339AbRERPLx>; Fri, 18 May 2001 11:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262341AbRERPLn>; Fri, 18 May 2001 11:11:43 -0400
Received: from t2.redhat.com ([199.183.24.243]:47867 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S262339AbRERPLa>; Fri, 18 May 2001 11:11:30 -0400
Message-ID: <3B053B9B.23286E6C@redhat.com>
Date: Fri, 18 May 2001 16:11:23 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <20010518034307.A10784@thyrsus.com> <E150fV9-0006q1-00@the-village.bc.nu> <20010518105353.A13684@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    (a) Back off the capability approach.  That is, accept that
>        people doing configuration are going to explicitly and
>        exhaustively specify low-level hardware.

<snip>

 
> I don't want to do (a); it conflicts with my design objective of
> simplifying configuration enough that Aunt Tillie can do it.  I won't
> do that unless I see a strong consensus that it's the only Right Thing.

Aunt Tillie doesn't even know what a kernel is, nor does she want to. I
think 
it's fair to assume that people who configure and compile their own
kernel 
(as opposed to using the distribution supplied ones) know what they are
doing.

Or at least make something like a "Expert level" question as first
question, so 
that people who DO know what they are doing can select the options they
want.
Going from "make config" (which has a scary interface for novice users,
agreed)
to "vi" is NOT progress.

Greetings,
   Arjan van de Ven
