Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277178AbRJDIa2>; Thu, 4 Oct 2001 04:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277179AbRJDIaR>; Thu, 4 Oct 2001 04:30:17 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:52829 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S277178AbRJDIaC>; Thu, 4 Oct 2001 04:30:02 -0400
Date: Thu, 4 Oct 2001 11:30:19 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011004113019.L22640@niksula.cs.hut.fi>
In-Reply-To: <Pine.GSO.4.21.0110040004430.26177-100000@weyl.math.psu.edu> <m14rpg0w4a.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m14rpg0w4a.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Thu, Oct 04, 2001 at 12:15:01AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 12:15:01AM -0600, you [Eric W. Biederman] claimed:
> 
> <snip size of glibc>

Where size is an issue, diet libc might be an alternative:

http://www.fefe.de/dietlibc/

(287kB statically linked zsh is not too shabby, I reckon.)

That and things like busybox:

http://busybox.lineo.com/

I have no suggestion wrt the kernel, though.


-- v --

v@iki.fi
