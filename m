Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbTF2UZj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264908AbTF2UZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:25:22 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:45409 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264025AbTF2UXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:23:45 -0400
Date: Sun, 29 Jun 2003 16:36:15 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <3EFF4677.4050002@sktc.net>
To: "David D. Hagood" <wowbagger@sktc.net>, linux-kernel@vger.kernel.org
Message-id: <200306291636150850.0241B66C@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <20030629192847.GB26258@mail.jlokier.co.uk>
 <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
 <200306291545410600.02136814@smtp.comcast.net> <3EFF4677.4050002@sktc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 3:05 PM David D. Hagood wrote:

>rmoser wrote:
>
>> no, in-kernel conversion between everything.  You don't think it can be
>done?
>> It's not that difficult a problem to manage data like that :D
>
>OK, then - Show Us The Code.
>
>Everyone else who have expressed an opinion believe an in-kernel
>converter to be far to difficult to get right. You disagree, and think
>it should be easy.
>
>So write it. Show us the code. Change our minds.
>
>You opened with a a "This should be possible". We raised you a "No, it's
>hard, here's other ways to do it." You raised with a "It should be
>easy." I call.
>

Told you, I can't code it.  I could work on making an initial design for the
most important part though, the datasystem that separates the two filesystems
and holds the meta-data and data in self-contained atoms.  I KNOW I won't
get it right the first time, but I can give you a place to start.

I absolutely can not code anything in the kernel at this time.  I've tried.  I'll
get it eventually ;-)

Citing the original message:

[QUOTE]
I know I spout a lot of crap, and wish I could just do it all (can we get
a "Make a small device driver for virtual hardware in Linux 2.4 and 2.5"
tutorial up on kernel.org?!), but I think I've got some good ideas.  At
any rate, the good is kept and the bad is weeded out, right?
[ENDQUOTE]

I actually started pretty sure that someone would want me to come up
with an initial design for the datasystem that is used to control this.
Not that I drew it out before-hand, mind you; I just thought someone
would ask.  I KNEW someone would tell me to code it, which is why
I said I can't right off the bat.

>Let's see your cards.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

--Bluefox Icy

