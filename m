Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289880AbSAKCMj>; Thu, 10 Jan 2002 21:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289877AbSAKCM3>; Thu, 10 Jan 2002 21:12:29 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:61116 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S289836AbSAKCMO>; Thu, 10 Jan 2002 21:12:14 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [patch] O(1) scheduler, -H4 - 2.4.17 problems
Date: Fri, 11 Jan 2002 03:10:59 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Ingo Molnar <mingo@elte.hu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020111021221Z289836-13997+3739@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 00:52:16AM, khromy wrote:
> On Thu, Jan 10, 2002 at 07:43:04PM -0500, Ed Tomlinson wrote:
> > Incase I messed up removing and repatch I tried from a clean kernel with
> > the same results.
> > Any one else seeing this?
>
> Yes.. This is a PII350 with 128MiB... If anybody needs any more info let
> me know.

-H5 (-G1, latest I've tried worked)

1 GHz Athlon II, 640 MB 
hang hard right after
Initializing RT netlink socket

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
