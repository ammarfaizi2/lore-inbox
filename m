Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264795AbSLaW1p>; Tue, 31 Dec 2002 17:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbSLaW1p>; Tue, 31 Dec 2002 17:27:45 -0500
Received: from mail.webmaster.com ([216.152.64.131]:57571 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S264755AbSLaW1o> convert rfc822-to-8bit; Tue, 31 Dec 2002 17:27:44 -0500
From: David Schwartz <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Tue, 31 Dec 2002 14:36:08 -0800
In-Reply-To: <Pine.LNX.4.10.10212310412290.421-100000@master.linux-ide.org>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20021231223609.AAA23921@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Recall the kernel is capable of rejecting non-gpl binary modules; yet it
>does not!  Regardless of the original intent or scope of the "tainting
>process", it created more grey than clarity.

	Nothing would stop someone from distributing a kernel that did not reject 
those drivers. The GPL doesn't permit you to add additional restrictions to 
it, so you can't add a clause prohibiting such distribution.

>Now until the kernel forcable rejects loading binary closed source
>modules, it defaults to quietly approved of the concept regardless what
>you think, feel, or care.

	There would just be a set of patches to bypass that rejection. Every major 
distribution would distribute kernels with those patches. You can't GPL code 
and at the same time control how it is used.

	As I argued in my previous post, it would be suicidal for any advocate of 
open source to attempt to broaden the scope of what constitutes a 'derived 
work' or narrow the scope of fair use or first sale type doctrines.

	Hey, we're almost back on topic for this list. Happy new year.

	DS



