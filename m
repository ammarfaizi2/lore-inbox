Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272522AbTGZOoa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272530AbTGZOnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:43:13 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:49289
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272513AbTGZOfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:35:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ismael Valladolid Torres <ismael@sambara.org>,
       Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Sun, 27 Jul 2003 00:54:53 +1000
User-Agent: KMail/1.5.2
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <20030726101015.GA3922@eugeneteo.net> <3F226F58.2060301@sambara.org>
In-Reply-To: <3F226F58.2060301@sambara.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307270054.53705.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jul 2003 22:08, Ismael Valladolid Torres wrote:
> Eugene Teo escribe el 26/07/03 12:10:
> > What I really want to see is the best of both worlds if possible.
> > Well, some may be more keen to see responsiveness in work-related
> > tasks, there are others who wants more responsiveness in their
> > leisure-related work. I hope that Con do not stop developing his
> > interactive improvements just because mingo is starting to work
> > his too.
>
> Of course! Let us have the choice between different kernel patches for
> different latency and responsiveness needs, and let us build whichever
> kernel we want, according to the use we intend to give to our system.

While this may sound like a solution, I still believe one scheduler should 
perform well in as many settings as possible without a different kernel tree. 
You can bet your bottom dollar the alternative 2.6 trees will be out as fast 
as you can say Andrea Arcangeli anyway, but let's get the main tree as 
versatile as possible.

Con

