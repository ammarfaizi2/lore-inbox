Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbUKGTVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUKGTVa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 14:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbUKGTVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 14:21:30 -0500
Received: from smtpout6.uol.com.br ([200.221.11.59]:55032 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261677AbUKGTV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 14:21:27 -0500
Date: Sun, 7 Nov 2004 17:21:02 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops with kernel 2.6.9-ac6
Message-ID: <20041107192102.GA6423@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041104232704.GA7721@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041104232704.GA7721@ime.usp.br>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 04 2004, Rogério Brito wrote:
> Dear kernel developers (and Alan Cox in particular),
> 
> I've been having problems with recent kernels (some instability
> on a system that has been rock solid for years). I'm using a Debian testing
> system here with my own compiled kernel.
(...)

After running memtest86+, I discovered that the instability was due to a
faulty memory module. Now, running without that memory module, the machine
is again rock stable with 2.6.9-ac6 (but, unfortunately, quite slower).


Sorry for the red herring, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
