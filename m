Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292707AbSCSVJM>; Tue, 19 Mar 2002 16:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292700AbSCSVJC>; Tue, 19 Mar 2002 16:09:02 -0500
Received: from [195.39.17.254] ([195.39.17.254]:56194 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S292707AbSCSVIu>;
	Tue, 19 Mar 2002 16:08:50 -0500
Date: Tue, 19 Mar 2002 15:06:55 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dan Maas <dmaas@dcine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unwanted disk access by the kernel?
Message-ID: <20020319150654.B55@toy.ucw.cz>
In-Reply-To: <20020315013644.A26891@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've been trying to set up my laptop for mobile use. I'm having a
> problem with unwanted disk activity - even when the system is
> completely idle, there is still an occasional trickle of disk writes
> (which prevents the poor hard drive from ever spinning down). 

Get noflushd.
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

///////
