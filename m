Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262825AbSJ1ECl>; Sun, 27 Oct 2002 23:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbSJ1ECl>; Sun, 27 Oct 2002 23:02:41 -0500
Received: from ns.suse.de ([213.95.15.193]:53510 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262825AbSJ1ECk>;
	Sun, 27 Oct 2002 23:02:40 -0500
Date: Mon, 28 Oct 2002 05:09:00 +0100
From: Andi Kleen <ak@suse.de>
To: Rob Landley <landley@trommello.org>
Cc: Andrew Pimlott <andrew@pimlott.net>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
Message-ID: <20021028050900.B2558@wotan.suse.de>
References: <200210251557.55202.landley@trommello.org.suse.lists.linux.kernel> <20021027080125.A14145@wotan.suse.de> <20021027152038.GA26297@pimlott.net> <200210271157.46153.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210271157.46153.landley@trommello.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A) the spurious rebuild is still a tiny fraction of a second.

It can trigger other rebuilds which can take much longer.

-Andi
