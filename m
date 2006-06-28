Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423282AbWF1Lkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423282AbWF1Lkx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932791AbWF1Lkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:40:53 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:53176 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S932788AbWF1Lkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:40:52 -0400
X-Auth-Info: l5xqL9A/3XUiKMZJTpSqLPh+7mcA1v1HiHr1xJR+H6Q=
Date: Wed, 28 Jun 2006 13:41:47 +0200
From: Christian Lohmaier <cloph@openoffice.org>
To: linux-kernel@vger.kernel.org
Subject: OT: Confusions/Misunderstandings (was: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read atip wiith cdrecord)
Message-ID: <20060628114146.GB4126@bm617259.muenchen.org>
Reply-To: cloph@openoffice.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44A22D61.nail3NM11WN2Y@burner>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörg,

I set a reply-to, maybe the mailinglist keeps it, maybe not.
Since this "dispute" doesn't help anybody in solving the problem, please
reply to me personally, not on the list.

On Wed, 28 Jun 2006 09:20:08 +0200, Joerg Schilling wrote:
> Christian Lohmaier wrote: 
>>On Mon, 26 Jun 2006 20:30:19 +0200, Joerg Schilling wrote: 
>>> Christian Lohmaier wrote: 
>>>>> Why don't you just compile a recent version by your own? 
> 
>>>> How would I compile the closed-source cdrecord-prodvd 
>>>> myself? 
> 
>>> ???? 
>>> are you kidding? 
> 
>>No, but you are apparently talking about a totally different thing 
>>again. 
> 
>>????

Problem here: Kernel bug that ignores a set timeout.

You: Opening a side-track about compiling cdrecord.

I mentioned in a side-remark that I cannot use newer precompiled
versions of cdrecord-proDVD since my version of glibc is too old. 

I wrote this because I was asked to try with cdrecord-proDVD.
To avoid further questions like "Why don't you try with a more recent
version?" - I add the info that
cdrecord-prodvd-2.01b31-i686-pc-linux-gnu is the latest I can use
because of the reason mentioned above.

> You are confusing people here and I am not shure about your intention.....

No - you was making a whitty comment, maybe trying to make people aware
that the "default" cdrtools now contain DVD-support.

>>> ftp://ftp.berlios.de/pub/cdrecord/aplha/ 
> 
>>I cannot find sources for the *proDVD* version there. Yes, I even 
>>corrected the typo. 
> 
> Is this an attempt tp give wrong information by intention, or are you just
> too lazy inform yourself?

Apparently I'm too dumb to understand what is obvious to you. Please
enlighten me.
 
>>If you mean that the newer alphas are all "proDVD" versions because they 
>>now contain dvd-support, you're just confusing people here. 
> 
> ????
> 
> No, it's *you* who is confusing people.

Then please explain what all this has to do with the problem of the
kernel-bug?

>>Even more so because *you already know* that I compiled the new alphas 
>>myself. Trying them and having my cdburner not working anymore made me 
>>start all this. 
> 
> From your information, it does not look as if you did compile and use
> recent versions of cdrecord.

So when cdrtools 2.01.01a10 and 2.01.01a09 are not recent versions, just
tell me where to get a more recent one.

You know that I use that version since that is what I wrote into the
bug-report and also in the thread on dclhb.

> It is obvious that you cannot expect software to work if it triggers
> a OS bug.

Yes. I don't question that.

But there are two ways a user can be satisfied:
* Workaround the bug in the software
* Fix the kernel

>>By asking such question, assuming "insider" knowledge and despite you 
>>already knowing the answer, you're not helping people to focus on the 
>>real problem, 
> 
> ????
> 
> Again: you are definitely confusing people and I am not sure whether you 
> do this by intention or by mistake.

<sigh>. By only using ???? again and again and not explaining things,
telling the user what he does wrong, you don't contribute to avoiding
this confusion.

It is still not clear to me what /you/ were trying to achieve with your
comment "compile yourself" and then with the "are you kidding" after my
reply. If it is only because you have missed that I already was trying
with the most recent version?

Anyway: This is helping nobody to fix the kernel-bug, so this discussion
should be continued elsewhere (if you think it is necessary - I don't). 

Feel free to continue by private mail or in dchlb

ciao
Christian
-- 
NP: Dimmu Borgir - Stormblåst
