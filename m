Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbWFTGui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWFTGui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbWFTGui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:50:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:54690 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965096AbWFTGui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:50:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kLigxARGnllUi3GgEzoS+vbR0bXAHx28ONxl8AYhxhg8To+CAIAsnA0z+ItIIa1UhERQEnqLXQ74Az38Z7W28RjcwyFikymexuoc4fDmClBSG7cqTgxZsuhZPHnki/Lpccr4pV+Z10dCE5sztqgbtWdBFkFf8RxTdE2q7jCScBE=
Message-ID: <3aa654a40606192350w5c469670t466dfc1344e23a4@mail.gmail.com>
Date: Mon, 19 Jun 2006 23:50:37 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
In-Reply-To: <20060620164338.A1080488@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com>
	 <20060620161006.C1079661@wobbly.melbourne.sgi.com>
	 <3aa654a40606192338v751150fp5645d1d2943316ea@mail.gmail.com>
	 <20060620164338.A1080488@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/06, Nathan Scott <nathans@sgi.com> wrote:
> Oh - thats a kernel patch, not a repair patch, I was more interested
> in whether the initial corruption could be reproduced.  Which version
> of xfs_repair are you running?  (xfs_repair -V)  xfsprogs-2.7.18 will
> resolve your problem, I suspect.

OK, I'm running Gentoo's latest: 2.7.11, I can't find 2.7.18
_anywhere_ although 2.7.13 is in the pre directory on the ftp, is that
the one you're referring to?
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
