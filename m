Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311279AbSCQDWT>; Sat, 16 Mar 2002 22:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311275AbSCQDWJ>; Sat, 16 Mar 2002 22:22:09 -0500
Received: from odeon.net ([63.229.205.185]:50150 "HELO titan.odeon.net")
	by vger.kernel.org with SMTP id <S311274AbSCQDV4>;
	Sat, 16 Mar 2002 22:21:56 -0500
Message-ID: <4348.199.37.181.40.1016335310.squirrel@mail.odeon.net>
Date: Sat, 16 Mar 2002 21:21:50 -0600 (CST)
Subject: Re: /dev/md0: Device or resource busy
From: "Robert Hayden" <rhayden@geek.net>
To: alan@lxorguk.ukuu.org.uk
In-Reply-To: <E16mRJX-00082B-00@the-village.bc.nu>
In-Reply-To: <E16mRJX-00082B-00@the-village.bc.nu>
Cc: dean-list-linux-kernel@arctic.org, linux-kernel@vger.kernel.org
Reply-To: rhayden@geek.net
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan et al,

I have this happen quite frequently as well, and only on /dev/md0.  I end up
having to reboot to single user to work with it in these situations.  The
other md devices (two others) stop and start just fine. 

> lsof isnt always the most reliable to tools if a kernel thread or nfs
> ran off with it. Is md0 doing anything else - like rebuilding. Is there
> anything that has been triggered or run from it - paticularly kernel
> threads


