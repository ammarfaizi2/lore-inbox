Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319309AbSIKRSg>; Wed, 11 Sep 2002 13:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319311AbSIKRSf>; Wed, 11 Sep 2002 13:18:35 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:923 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S319309AbSIKRSU>; Wed, 11 Sep 2002 13:18:20 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Hans Reiser <reiser@namesys.com>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [reiserfs-list] [BK] ReiserFS file write bug fix for 2.4
Date: Wed, 11 Sep 2002 19:34:11 +0200
User-Agent: KMail/1.4.3
References: <3D7F7783.6030804@namesys.com>
In-Reply-To: <3D7F7783.6030804@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209111934.11373.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 September 2002 19:04, Hans Reiser wrote:
> Well, at least getting the new file write code into pre6 found this bug
> for us....  please apply.

What is the "right" way to get the new block allocation going?
The mount option (-o alloc=prealloc min=4:preallocsize=9) only or better a 
"reformat"?

Thanks,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)

