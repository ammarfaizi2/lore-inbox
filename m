Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWAVXAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWAVXAM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 18:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWAVXAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 18:00:12 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:41026 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932347AbWAVXAK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 18:00:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=to6GcXmZ6iuYNHgi4bMUwA39Oa0vSIA3Aln56UJ8cwdaKXyLL5qD4tpKNwVPlMtv3vDEdJgnydJe9h/iBBZLZfaeQqP/g7wVSIbbyWzktHaVkxQCHKiVP/4pM59ZS9eD2Ib0ZMYXsyHWZy8n/YI3C12z4h84tygZcDvyX5XZs3s=
Message-ID: <9a8748490601221452j41491984j6da14fa53ba9af55@mail.gmail.com>
Date: Sun, 22 Jan 2006 23:52:52 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: [PATCH 0/4] pmap
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org
In-Reply-To: <200601222215.k0MMFOYD213932@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601222215.k0MMFOYD213932@saturn.cs.uml.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/06, Albert D. Cahalan <acahalan@cs.uml.edu> wrote:
>
[snip]
>
> I found an old email account that still supports adding raw binay data
> to an email message body. I really wish we could get away from this,

1. having patches inline in messages instead of as attachments make
initial viewing of the patches much easier - no need to open a
sepperate attachment just to review a patch.
2. Commenting on patches is a lot easier when you can just reply to
the message and have the patch quoted inline and then add your
comments.
3. saving patches for application is easy when you can just save the
email message with the patch inline - then you have the explanation of
the patch and the patch itself nicely contained in a single file (and
patch will conveniently strip the extra text before the patch-proper
when you apply it).
4. You don't need an account that's able to add 'binary data' -
patches should preferable be in 7-bit ASCII text form, not 8-bit.

And if your current MUA doesn't allow you to add text files inline,
then there are several that do - mutt, pine & kmail come to mind and
there are several others.

> because it makes contributions damn near impossible for some people.
> Other people are far worse off than I am.
>
I'm currious - in what situations are you prevented from sending
patches inline in emails??


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
