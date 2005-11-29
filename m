Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVK2Tw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVK2Tw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 14:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbVK2Tw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 14:52:56 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:4180 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932367AbVK2Twz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 14:52:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HsmS2nFVORetFMivYpWjfsVgRFDh0VWaSM+eDt8xX4aauCcPFbuTqp8rd5H+aXIabH5W4HS84NOsRsu9ovpiUPIiYYTLdRk9q4anYmg5K81v7lmDI2hQGb3IgqQ7KDrt68UOP5rZ/9e3pM7Slb1Bs9yOBdlCR0sWMQqczrjyZ28=
Message-ID: <9a8748490511291152q13db77aaib9a5a3f97934b2bc@mail.gmail.com>
Date: Tue, 29 Nov 2005 20:52:54 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Subject: Re: Outlook Sux (Was: [2.6 patch] dpt_i2o fix for deadlock condition)
Cc: Adrian Bunk <bunk@stusta.de>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3DE12@otce2k03.adaptec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3DE12@otce2k03.adaptec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/05, Salyzyn, Mark <mark_salyzyn@adaptec.com> wrote:
> From: Adrian Bunk [mailto:bunk@stusta.de] writes:
> >> There must still be a way to tell outlook to make the type something
> >> useful, rather than application/octet-stream.  maybe if the extension
>
> >> was .patch.txt it would do something smarter.
> > Patches in Attachments aren't nice, but better than corrupted patches.
>
> :-)
>
> Part of the problem is cut-n-paste engines on M$ and preservation of
> content, the other part of the problem is the MUA making up it's own
> rules on what constitutes a text document. It is not the MTA, sendmail
> is blameless.
>
> > It's unfortunate, but bitching on the people who are somehow forced to
>
> > use crappy email clients is IMHO not a good idea.
>
> We could always require that if a patch is done as an attachment, that
> if it is smaller than 2K and/or at the submitters option, it also be
> present as in-line content for code review convenience?
>
> Thanks for that defense, I appreciate it. I am trapped in corporate
> policy and MIS monitoring requirements. I have tried to make our MIS
> department miserable over this issue, the sheer quantity of attempts to
> mitigate is boggling and is still open. If I was paranoid, I'd almost
> believe that M$ specifically decided to ignore RFC822 and all it's
> children just to make it an impossible tool to use for submitting Linux
> patches.
>

I've myself worked in places that required the use of outlook, but
luckily I've always been able to persuade those employers to let me
use other MUA's as long as they were able to work with the MS Exchange
server. For those situations I've been using pine and kmail with
success. Would that be an option for you?  pine will even run on
Windows if that's a corporate requirement as well.


> Now, if *someone* had an idea how I could configure Outlook 2002 to
> properly produce in-line patches *that* would earn my eternal gratitude
> (or a single stay at Hotel Salyzyn when visiting the Orlando Mouse House
> ;-> ). Outlook 2003 gets worse still by corrupting attachments (!) and I
> thus reverted back to 2002.
>
Since I don't use Outlook myself I don't really know. But I wen't
googling and found a few links that perhaps can help you.

http://email.about.com/od/outlooktips/qt/et010406.htm
http://www.expita.com/nomime.html#out2002
http://support.microsoft.com/default.aspx?scid=kb;EN-US;q278134
http://www.scheduleworld.com/outlookInteroperability.html

Please note that I'm not recommending anything mentioned in those
documents, I've never used those methods and I've barely ever touched
Outlook, they are just the result of a quick google search.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
