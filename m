Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUJBPxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUJBPxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 11:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUJBPxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 11:53:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:705 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266854AbUJBPxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 11:53:05 -0400
To: george@mvista.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       juhl-lkml@dif.dk, clameter@sgi.com, drepper@redhat.com,
       johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
Subject: Re: patches inline in mail
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
	<4154F349.1090408@redhat.com>
	<Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
	<41550B77.1070604@redhat.com>
	<B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
	<4159B920.3040802@redhat.com>
	<Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
	<415AF4C3.1040808@mvista.com>
	<Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com>
	<415B0C9E.5060000@mvista.com>
	<Pine.LNX.4.61.0409292143050.2744@dragon.hygekrogen.localhost>
	<415B4FEE.2000209@mvista.com> <20040930222928.1d38389f.akpm@osdl.org>
	<1096633681.21867.14.camel@localhost.localdomain>
	<415DD31A.3020004@mvista.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 02 Oct 2004 17:52:34 +0200
In-Reply-To: <415DD31A.3020004@mvista.com> (George Anzinger's message of
 "Fri, 01 Oct 2004 14:58:50 -0700")
Message-ID: <87vfdtglrx.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

George Anzinger <george@mvista.com> writes:

> Alan Cox wrote:
>> The mozilla behaviour is RFC compliant[1]. Use text/plain attachments
>> and mark them "to view" and it should do happier things. (Except with
>> Linus cos Mr Dinosaur[2] doesn't believe in MIME yet)
>
> Just how does one "mark them "to view" "?

I don't know how to do this with mozilla, but I suppose it's:
"Content-Disposition: inline"

RFC 2183 <ftp://ftp.rfc-editor.org/in-notes/rfc2183.txt>

See:
2.1  The Inline Disposition Type
and
3.  Examples

Regards, Olaf.


--=-=-=
Content-Disposition: inline; filename=attachment
Content-Description: Attachment test

This is an attachment test.

--=-=-=--
