Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286087AbRLTFKt>; Thu, 20 Dec 2001 00:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286099AbRLTFKj>; Thu, 20 Dec 2001 00:10:39 -0500
Received: from bexfield.research.canon.com.au ([203.12.172.125]:51037 "HELO
	b.mx.canon.com.au") by vger.kernel.org with SMTP id <S286087AbRLTFK2>;
	Thu, 20 Dec 2001 00:10:28 -0500
Date: Thu, 20 Dec 2001 16:10:21 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, billh@tierra.ucsd.edu,
        bcrl@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011220161021.A3303@zapff.research.canon.com.au>
Reply-To: cs@zip.com.au
In-Reply-To: <20011219135708.A12608@devserv.devel.redhat.com> <20011219.161359.71089731.davem@redhat.com> <20011219171631.A544@burn.ucsd.edu> <20011219.172046.08320763.davem@redhat.com> <mailman.1008816001.10138.linux-kernel2news@redhat.com> <200112200507.fBK57LC25752@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112200507.fBK57LC25752@devserv.devel.redhat.com>; from zaitcev@redhat.com on Thu, Dec 20, 2001 at 12:07:21AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 12:07:21AM -0500, Pete Zaitcev <zaitcev@redhat.com> wrote:
| >[...]
| > However, heavily threaded apps regardless of language are hardly likely
| > to disappear; threads are the natural way to write many many things. And
| > if the kernel implements threads as on Linux, then the scheduler will
| > become much more important to good performance.
| 
| Cameron seems to be arguing with DaveM,

About the wrong things, but no matter.

| but subconsciously he
| only supports DaveM's point about AIO: Java cannot make use
| of AIO, so that's one (large or small, important or unimportant)
| group of applications down from the count.

You're sure? Java _authors_ can't make use of it, but Java _implementors_
probably have good reason to want it ...

| Just trying to keep on topic :)

Whatever for?
--
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

Reaching consensus in a group often is confused with finding the right
answer.	- Norman Maier
