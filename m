Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbRE2PWc>; Tue, 29 May 2001 11:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbRE2PWW>; Tue, 29 May 2001 11:22:22 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:57361 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261679AbRE2PWG>;
	Tue, 29 May 2001 11:22:06 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Nico Schottelius <nicos@pcsystems.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbols printk ? 
In-Reply-To: Your message of "Tue, 29 May 2001 15:54:36 +0200."
             <3B13AA1C.AF1F86F9@pcsystems.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 May 2001 00:55:11 +1000
Message-ID: <8463.991148111@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001 15:54:36 +0200, 
Nico Schottelius <nicos@pcsystems.de> wrote:
>Just a small question, what could be the reason I have a broken
>Makefile ?
>This seems to happen frequently, if there is a need
>to name it into the lkml. I am surprised
>a makefile gets screwed up ?

It is the makefile design for modversions that is broken.  The entire
makefile system is being redesigned and rewritten from scratch for
kernel 2.5.

