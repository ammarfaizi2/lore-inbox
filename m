Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSAQBRG>; Wed, 16 Jan 2002 20:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSAQBQ4>; Wed, 16 Jan 2002 20:16:56 -0500
Received: from redazione.oltrelinux.com ([80.17.149.253]:3478 "HELO
	oltrelinux.com") by vger.kernel.org with SMTP id <S288010AbSAQBQj>;
	Wed, 16 Jan 2002 20:16:39 -0500
Date: Thu, 17 Jan 2002 02:16:40 +0100 (CET)
From: Andrea Scrimieri <livore@karma.oltrelinux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Rik spreading bullshit about VM
Message-ID: <Pine.LNX.4.40L0.0201170137380.32025-100000@karma.oltrelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Rik van Riel wrote:

> It seems the IRC log of the journalist in question was missing
> some lines of what I said and he just glued together the remaining
> parts of the paragraph for that particular question ;)
>
> The rest of the interview seems to have survived pretty ok, though.


I'm sorry but you are wrong. The interview was published untouched.
Nothing was cut or moved. These are my IRC logs about the paragraph you're
talking about.


---START---
[msg(riel)] With kernel 2.4.10 we have seen that Linus Torvalds has
preferred Arcangeli's VM to yours. What do you think of his decision? And
why has he made that?


[riel(dsiumz@Star6583.ctame701-1.telepar.net.br)] it was a strange
situation, first Linus ignores bugfixes by me and Alan for almost a year,
then he complains we "didn't send" him the bugfixes and he replaces the VM
of course, the new VM has better performance than the old VM for typical
desktop systems ... but it fails horribly on more systems than the old VM
Redhat, for example, cannot ship the new VM in their distribution because
it'll just fall apart for the database servers some of their users run at
least now my code is gone I no longer have to work together with Linus,
which is a good thing ;)

[msg(riel)] Why is it a good thing?

[riel(dsiumz@Star6583.ctame701-1.telepar.net.br)] with Linus out of the
way,
I can make a good VM. I no longer have to worry about what Linus likes or
doesn't like. This is mostly important for intermediary code, where some
of
the "ingredients" to a VM are in place and others aren't yet in place such
code can look ugly or pointless if you don't have the time to look at the
design for a few days, so Linus tends to remove it ... even though it is
needed to continue with development

---END---

The original IRC interview was made in english: as we didn't want to
change anything said by Rik, we didn't correct even grammatical or
syntactical errors. I even left emoticons as they were typed...


Best regards,
Andrea Scrimieri

