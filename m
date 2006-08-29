Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWH2AV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWH2AV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 20:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWH2AV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 20:21:59 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:15112 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S964936AbWH2AV6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 20:21:58 -0400
To: dmarkh@cfl.rr.com
Cc: Lee Revell <rlrevell@joe-job.com>, Luka Marinko <luka.marinko@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: question on pthreads
References: <3420082f0608201046q53bb60b5u5ca8915e588ee9e3@mail.gmail.com>
	<ecakcv$m06$1@sea.gmane.org> <1156112486.10565.64.camel@mindpipe>
	<44E98ECB.3040603@cfl.rr.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: more than just a Lisp interpreter, a text editor as well!
Date: Tue, 29 Aug 2006 01:21:49 +0100
In-Reply-To: <44E98ECB.3040603@cfl.rr.com> (Mark Hounschell's message of "21 Aug 2006 11:46:09 +0100")
Message-ID: <87r6z0pf1e.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Aug 2006, Mark Hounschell said:
> glibc 2.4.31 has a man page for it.
> 
> PTHREAD_MUTEXATTR_GETPSHARED(P)                                 POSIX
> Programmer's Manual                                PTHREAD_MUTEXATTR_GETPSHARED(P)

That's not in glibc, that's in the POSIX part of the manpages
distribution.

-- 
`In typical emacs fashion, it is both absurdly ornate and
 still not really what one wanted.' --- jdev
