Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422766AbWBNTv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422766AbWBNTv1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422768AbWBNTv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:51:27 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:28612 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422766AbWBNTv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:51:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:from:organization:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=rY8+1YowYbB25Ubp9YLvE/t8ZCI/n7DJA59RfsBQoido9o0wp66MdGE15rvexv23xkov4aNev7J/mxC9Npv4MugTxJ1VWn1TUMl0Tdz7+MPyT1gnhSRSX6VpVSXfIarscJFoeYv8GvFiOze+xEUO1V56DTZkzli4lPmBewoZuhc=
Date: Tue, 14 Feb 2006 19:51:16 -0000
To: "Joerg Schilling" <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
From: "Anders Karlsson" <trudheim@gmail.com>
Organization: Trudheim Technology Limited
Cc: Valdis.Kletnieks@vt.edu, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jerome.lacoste@gmail.com,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
References: <515e525f0602141110r7a96568av4705c2a353407e6@mail.gmail.com> <43F22BCF.nailEW11NC25@burner>
Content-Transfer-Encoding: 8bit
Message-ID: <op.s4zarqjkiv906l@lenin>
In-Reply-To: <43F22BCF.nailEW11NC25@burner>
User-Agent: Opera Mail/9.00 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006 19:13:19 -0000, Joerg Schilling  
<schilling@fokus.fraunhofer.de> wrote:

> Anders Karlsson <trudheim@gmail.com> wrote:
>
>> It would appear that every time someone pose a question, you are
>> deliberately rude and avoid answering the question, yet when you ask a
>> question, the entire list is supposed to stand to attention and follow
>> you every little whim. My mother taught me a very good thing, when
>> everyone else appear to be wrong - they probably are right. Remember
>> where you are debating the issue JÃ¶rg. You are not on a Solaris
>> mailing list now.
>
> What would you do if you write things and a few minutes later someone
> replies with something that either does not aply at all or is wrong?

The code I have written has mainly been Perl or shell script,
and while it is not used by tens of thousands of people around
the globe I have a few users that ask why I do things this way
or that way. I explain why, I encourage them to look at the
code and I *want* them to come with suggestions - because
*I will learn things if they do*.

cdrecord is a very useful tool, I have used it before, I will
probably use it again. However, people are pointing out quirks
in the user interface, they have offered patches, they have
offered to work on problems in the Linux kernel and yet you
insist that cdrecord/libscg is right and Linux users are wrong.
What people have asked here is no more and no less than that
you consider altering the user interface of cdrecord to take
the device-name of a writer instead of the BTL address. They
have even offered to do the work.

I am sure you are as sick of this debate as everyone else is.
If you were to just consider the proposals that has been made,
for a minute ignoring the past two weeks aggravation, I am sure
that you can see the merits of them. No-one is asking you to
accept anything and everything patch-like thrown your way. What
we are saying is that in modern Linux distributions, users access
devices through /dev/devicename - that limits confusion. So far,
the _only_ programs I have encountered that does not use devices
in /dev is SANE - and cdrecord.

> This happens since 2 weeks now and I cannot see any progress.

To be fair, I have been more than a little sarcastic in this
discussion. I apologise if that has offended you or anyone else.
If you are fair to yourself, you will look back over the
discussion, see how you have responded to people and you may
understand their reactions as well. There has been far to much
pride and hot-headedness in this discussion. Are we not all
supposed to be on the same side? F/OSS vs Big Bad Corporations?

How about we all calm down, admit our own failings and look at
how we all can compromise and get a solution that all can agree
on - without letting our own pride and egos get in the way?

Kind regards,

PS, sorry about the essay.

-- 
Anders Karlsson <anders@trudheim.com>
QA Engineer | GnuPG Key ID - 0x4B20601A
