Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271711AbRIJU7N>; Mon, 10 Sep 2001 16:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271717AbRIJU7E>; Mon, 10 Sep 2001 16:59:04 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:28420 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S271711AbRIJU6x>;
	Mon, 10 Sep 2001 16:58:53 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Sun, 9 Sep 2001 12:48:29 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Josh McKinney <forming@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre5 (and gcc-3)
In-Reply-To: <20010908230539.A4927@home.com>
Message-ID: <Pine.LNX.4.21.0109091236220.6179-100000@pppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Sep 2001, Josh McKinney wrote:

> Since I have gotten a decent amount of flame mail from my one-liner posted 
> yesterday, I am just curious.  Has anyone really been able to successfully
> compile their kernel with gcc-3*.  I did once or twice long before it was
> released, but it dies on the same error everytime.

I had problems with pre-release versions, but gcc-3.0 works fine for
me. I've got two boxes with K6s, this one running 2.4.6 (gcc-3) and the
other was running various fairly recent kernels through to 2.4.8-pre3 
compiled with gcc-3. I've seen strange errors with 2.4.7-ac5 (messages about
loss of clock data, and trying to compile gcc-2.95.3 gave sig 11), but I'm 
not ready to lay those at the compiler's door. (The test box has turned into
a linux from scratch system using gcc-2.95.3, it will be a little while 
before I get gcc-3 back up on it).

Ken
-- 
         If a six turned out to be nine, I don't mind.

         Home page : http://www.kenmoffat.uklinux.net


