Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268934AbRIDUPP>; Tue, 4 Sep 2001 16:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268908AbRIDUOz>; Tue, 4 Sep 2001 16:14:55 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:37892 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S268901AbRIDUOq>;
	Tue, 4 Sep 2001 16:14:46 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: H.323 and 2.4
Date: 4 Sep 2001 19:29:31 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9paasr.8bf.kraxel@bytesex.org>
In-Reply-To: <999616751.3b94f0ef41ca8@webmail.fesppr.br>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 999631771 8560 127.0.0.1 (4 Sep 2001 19:29:31 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Hautequest wrote:
>  Hi all.
>  
>  The H.323 protocol, as many of you know, got some issues when used in a masq'ed
>  env. The guys at http://www.coritel.it/coritel/ip/sofia/nat/nat2/nat2.htm have a
>  2.2 module to solve this masq trouble.
>  
>  Anyone have any solution for 2.4?

Checkk netfilter maillist archive + cvs.  There was some discussion
about that recently.

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
