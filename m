Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTCEMKG>; Wed, 5 Mar 2003 07:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbTCEMKG>; Wed, 5 Mar 2003 07:10:06 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:22723 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S266064AbTCEMJd>; Wed, 5 Mar 2003 07:09:33 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: reducing stack usage in v4l?
Date: 05 Mar 2003 13:28:30 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87llzugfpt.fsf@bytesex.org>
References: <32833.4.64.238.61.1046841945.squirrel@www.osdl.org> <87u1eigomv.fsf@bytesex.org> <1046865047.2310.33.camel@nirvana.flat>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1046867310 16998 127.0.0.1 (5 Mar 2003 12:28:30 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mdew <mdew@mdew.dyndns.org> writes:

> On the topic of v4l, Ive had complete lockups on recent 2.5.x kernels
> when loading a v4l application Zapping.

There are a few known issues, pushing updates to Linus is on my todo list.
If it still happens with the latest bits from http://bytesex.org/snapshot/
I'd like to know.

  Gerd

-- 
/join #zonenkinder
