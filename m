Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261779AbTCQQwM>; Mon, 17 Mar 2003 11:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261781AbTCQQwM>; Mon, 17 Mar 2003 11:52:12 -0500
Received: from buug.mind.de ([212.42.230.8]:2964 "EHLO mail.buug.de")
	by vger.kernel.org with ESMTP id <S261779AbTCQQwL>;
	Mon, 17 Mar 2003 11:52:11 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: BK->CVS is live
Mail-Followup-To: linux-kernel@vger.kernel.org
From: krause@sdbk.de (Sebastian D.B. Krause)
Date: Mon, 17 Mar 2003 18:02:56 +0100
In-Reply-To: <1047917511.28282.154.camel@passion.cambridge.redhat.com> (David
 Woodhouse's message of "17 Mar 2003 16:11:52 +0000")
Message-ID: <87k7eyudrz.fsf@sdbk.de>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <200303171552.h2HFqK907234@work.bitmover.com>
	<20030317155845.GH17073@lug-owl.de>
	<1047917511.28282.154.camel@passion.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3484 September 1993, David Woodhouse wrote:
> On Mon, 2003-03-17 at 15:58, Jan-Benedict Glaw wrote:
>> Allowing rsync on the repository could help people on slow links (modem)
>> esp. as CVS isn't exactly known to be fast and evvective. I'd love to
>> have it rsyncable (as we have it for mips-linux:-)
>
> And/or cvsup?

That would be nice and easy to set up because Larry could just use
cvsup with the current CVS-repository. And it would be much faster
than cvs.
