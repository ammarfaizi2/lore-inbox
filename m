Return-Path: <linux-kernel-owner+w=401wt.eu-S1751483AbWLQAWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWLQAWT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 19:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWLQAWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 19:22:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:46180 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbWLQAWS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 19:22:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=O/I1mkjkenrYUxeCupMQgpPfnxcpbcTrUnOycc6SjChe0tuViYm335lhuD9SlgaoMmX86umrN3as4OywaKI6oETu/XhsTjGvy3P0FW0UefXcN7Ez4Mgl16jk6cwg5Vlc9KbROjt3/vql0NPZkJKq+1AasKT2Wq8jKZiq4lFMHjE=
From: Ricardo Galli <gallir@gmail.com>
Organization: UIB/Gmail
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Date: Sun, 17 Dec 2006 01:22:12 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200612161927.13860.gallir@gmail.com> <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612170122.13246.gallir@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 December 2006 22:01, Linus Torvalds wrote:
> On Sat, 16 Dec 2006, Ricardo Galli wrote:
> > As you probably know, the GPL, the FSF, RMS or even GPL "zealots" never
> > tried to change or restrict "fair use". GPL[23] covers only to
> > "distibution" of the covered program. The freedom #0 says explicitly:
> > "right to use the program for any purpose".
>
> I'm sorry, but you're just rewriting history.
>
> The FSF very much _has_ tried to make "fair use" a very restricted issue.
> The whole reason the LGPL exists is that people realized that if they
> don't do something like that, the GPL would have been tried in court, and
> the FSF's position that anything that touches GPL'd code would probably
> have been shown to be bogus.
>
> In reality, if the FSF actually believed in "fair use", they would just
> have admitted that GNU libc could have continued to be under the GPL, and
> that any programs that link against it are obviously not "derived" from
> it.
>
> But no. The FSF has very much tried to confuse and muddle the issue, and
> instead have claimed that projects like glibc should be done under the
> "Lesser" GPL.

OK, let assume your perspective of the history is the valid and real one, 
then, ¿where are all lawsits against other big GPL only projects? For example 
libqt/kdelibs. You can hardly provide any example where the GPL wasn't hold 
in court.

> The fact is, if you accept fair use, you have to accept it for other
> people to take advantage of too. Fair use really isn't just a one-way
> street.

"Fair use: The right set forth in Section 107 of the United States Copyright 
Act, to use copyrighted materials for certain purposes, such as criticism, 
comment, news reporting, teaching, scholarship, and research. The Copyright 
Act does not define fair use. Instead, whether a use is fair use is 
determined by balancing these factors: ..."

According to the law, I don't see how FSF tries to avoid or to reject the fair 
use rights.

It seems to me you provides us with a copyright law interpretation supported 
only by the very [narrow] exceptions of the copyright law, a logical fallacy.


-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/gallir/
