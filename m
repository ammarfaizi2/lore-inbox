Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbTBUSS0>; Fri, 21 Feb 2003 13:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267628AbTBUSS0>; Fri, 21 Feb 2003 13:18:26 -0500
Received: from host5.veoweb.net ([209.197.252.6]:16618 "EHLO host5.veoweb.net")
	by vger.kernel.org with ESMTP id <S267624AbTBUSSZ>;
	Fri, 21 Feb 2003 13:18:25 -0500
Message-ID: <3E566DC6.9040706@linuxtestproject.org>
Date: Fri, 21 Feb 2003 12:19:50 -0600
From: Paul Larson <plars@linuxtestproject.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@imladris.surriel.com>
CC: Paul Larson <plars@linuxtestproject.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.5 kernel errata list
References: <1045595639.28493.197.camel@plars> <Pine.LNX.4.50L.0302192230340.2329-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host5.veoweb.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - linuxtestproject.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply, I'm down with the flu atm.

Rik van Riel wrote:

>
>How is this different from the 2.5 bugzilla database ?
>
The bugzilla database tracks problems, whether they are fixed or not. 
 The errata list aims to be a quick (hopefully short) list of known 
fixes to problems.  Bugzilla also tracks all types of problems where the 
errata list will usually only contain fixes to major, blocking problems. 
 Basically I'm trying to keep a list that will help people quickly find 
the diffs against releases that will help them get up and running enough 
to test with.

Thanks,
Paul Larson

