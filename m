Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbTJFPJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 11:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTJFPJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 11:09:30 -0400
Received: from chaos.sr.unh.edu ([132.177.249.105]:7811 "EHLO chaos.sr.unh.edu")
	by vger.kernel.org with ESMTP id S262260AbTJFPJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 11:09:27 -0400
Date: Mon, 6 Oct 2003 11:09:33 -0400 (EDT)
From: Kai Germaschewski <kai.germaschewski@unh.edu>
X-X-Sender: kai@chaos.sr.unh.edu
To: Jan Schubert <Jan.Schubert@GMX.li>
cc: linux-kernel@vger.kernel.org, <kernelnewbies@vger.kernel.org>
Subject: Re: Q: Maintainer for drivers/isdn/hisax in kernel-2.6
In-Reply-To: <3F8090E7.9040501@GMX.li>
Message-ID: <Pine.LNX.4.44.0310061107140.16435-100000@chaos.sr.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Oct 2003, Jan Schubert wrote:

> Who is the Maintainer for the (old) ISDN-Hisax-Part for the kernel-2.6 
> (located in drivers/isdn/hisax)? I've digged into the code and got some 
> problems. IMHO there exist some old/outdated code which will never be 
> used in the current state (there are some Kernel-Config-Values which are 
> not defined or which will never be used). I tried to write an module to 
> get an Teles ISDN-PCMCIA Card running and run into some problems which 
> prevents me from further testing now.

Well, Karsten Keil and me are listed for that, and I think Karsten is 
actually actively working on fixing problems there. I've been far away 
from any ISDN equipment for the past 1 1/2 years now, which combined with 
a certain lack of time unfortunately reduced my ability to contribute, but 
I'm still there to take questions and review patches.

--Kai

