Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280450AbRJaTxK>; Wed, 31 Oct 2001 14:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280451AbRJaTxG>; Wed, 31 Oct 2001 14:53:06 -0500
Received: from [195.211.46.202] ([195.211.46.202]:29719 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S280450AbRJaTwx>;
	Wed, 31 Oct 2001 14:52:53 -0500
X-Spam-Filter: check_local@serv02.lahn.de by digitalanswers.org
Date: Wed, 31 Oct 2001 20:52:48 +0100 (CET)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
In-Reply-To: <Pine.LNX.4.33.0110302349550.31996-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110312032110.18881-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Linus Torvalds wrote:

> Incredibly, I didn't get a _single_ bugreport about the fact that I had
> forgotten to change the version number in pre5. Usually that's everybody's
> favourite bug.. Is everybody asleep on the lists?
Message-ID: <Pine.LNX.4.32.0110302228010.17012-100000@skynet>

> Other changes:
linux/zlib_fs.h is still missing in you tree and breaks compilation of
fs/cramfs and other.

http://marc.theaimsgroup.com/?l=linux-kernel&m=100407670605760&q=raw

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de



