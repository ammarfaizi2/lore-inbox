Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbSLPK70>; Mon, 16 Dec 2002 05:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbSLPK70>; Mon, 16 Dec 2002 05:59:26 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:12423 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S266609AbSLPK7Z> convert rfc822-to-8bit;
	Mon, 16 Dec 2002 05:59:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Wolfgang Fritz <wolfgang.fritz@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: i4l dtmf errors
Date: Mon, 16 Dec 2002 12:07:15 +0100
User-Agent: KMail/1.4.1
References: <200212121145.26108.roy@karlsbakk.net> <atg5jv$d73$1@fritz38552.news.dfncis.de>
In-Reply-To: <atg5jv$d73$1@fritz38552.news.dfncis.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212161207.15279.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The DTMF detection is broken since kernel 2.0.x. I have a patch for a
> 2.2 kernel which may manually be applied 2.4 kernels with some manual
> work. It fixes an overflow problem in the goertzel algorithm (which
> does the basic tone detection) and changes the algorithm to detect the
> DTMF pairs. If interested, I can try to recover that patch.

I'm very interested, as the alternative is to rewrite Asterisk (dot org) to 
use it's own. Today, I get beeps whenever I speak on the phone - espessialy 
with my girlfriend ;-P

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

