Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288780AbSA0WEz>; Sun, 27 Jan 2002 17:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288782AbSA0WEq>; Sun, 27 Jan 2002 17:04:46 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:47651 "EHLO
	tsmtp3.ldap.isp") by vger.kernel.org with ESMTP id <S288780AbSA0WEf>;
	Sun, 27 Jan 2002 17:04:35 -0500
From: "Diego Calleja" <grundig@teleline.es>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 2.4.17 crashes (VM bug?) after heavy system load
Date: dom, 27 ene 2002 22:05:03 +0000
In-Reply-To: <000001c1a77c$78abe8c0$6501a8c0@intranet.invantive.com>
X-Mailer: Pyne 0.6.7 (Debian/GNU/Linux)
Content-Type: text/plain
MIME-Version: 1.0
Cc: <guido.leenders@invantive.com>
Message-Id: <20020127220437Z288780-13996+13092@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 ene 2002, 22:49:17, Guido Leenders wrote:
> 
> [1.] One line summary of the problem:    
> 
> Especially during times of heavy I/O, swapping and CPU processing, the
> OS crashes with an Oops.
I think andrea's patches should be applied into stable mainline NOW. 
