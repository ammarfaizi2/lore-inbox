Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVDYRlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVDYRlM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVDYRik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:38:40 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:29986 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262668AbVDYRiW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 13:38:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=elLfoe3oCwxDUgDl8M1TsaPKcaKAiisQFeFgUWHN/Y37KI/sqhNGkRzeHgQPZeleCqs7Z35pmZVPis0SA9V+lc4cDkwMRz2c4r935o/k1hxjqwpXI/mrWg9Y1gAIkUIbetpR4FjWDtpKJMK1ug8TmSGXgX9Sw6+ngulM8dyt4o4=
Message-ID: <d120d500050425103822c3c9a1@mail.gmail.com>
Date: Mon, 25 Apr 2005 12:38:20 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <426D21FE.3040401@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <426CD1F1.2010101@tiscali.de>
	 <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
	 <426D21FE.3040401@tiscali.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/05, Matthias-Christian Ott <matthias.christian@tiscali.de> wrote:
> "register" and "auto" variables aren't relicts of the 60's,  they're a
> part of the ISO-C 99 standard, I'm following, "man".
...
> [2] Erik de Castro Lopo, Peter Aitken, Bradley L. Jones: Teach Yourself
> C for Linux Programming in 21 Days; SAMS Publishing; 1999

It must be "Teach yourself C for Gentoo Linux Programming..." "...
Gentoo rocks! I changed all my variables to 'register' and now my
kernel runs 3x times faster than RehHat one" :)

Sorry, couldn't resist...

-- 
Dmitry
