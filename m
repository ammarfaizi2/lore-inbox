Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136398AbREINCp>; Wed, 9 May 2001 09:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136399AbREINCf>; Wed, 9 May 2001 09:02:35 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:6917 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136398AbREINCZ>;
	Wed, 9 May 2001 09:02:25 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: sebastien person <sebastien.person@sycomore.fr>
cc: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: signal 
In-Reply-To: Your message of "Wed, 09 May 2001 14:28:16 +0200."
             <20010509142816.2af8bbbd.sebastien.person@sycomore.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 May 2001 23:02:19 +1000
Message-ID: <9426.989413339@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2001 14:28:16 +0200, 
sebastien person <sebastien.person@sycomore.fr> wrote:
>I'm trying to send signal from a kernel module to an user prog.

force_sig() in kernel/signal.c

