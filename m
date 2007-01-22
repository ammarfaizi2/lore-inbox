Return-Path: <linux-kernel-owner+w=401wt.eu-S1751813AbXAVP6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbXAVP6T (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbXAVP6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:58:19 -0500
Received: from [212.12.190.41] ([212.12.190.41]:32914 "EHLO raad.intranet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751813AbXAVP6S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:58:18 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.38
Date: Mon, 22 Jan 2007 18:59:47 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701221859.47380.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Ralf Baechle wrote:
> > On Sun, Jan 21, 2007 at 06:37:24PM +0200, S.ط£â€،aط¤إ¸lar Onur wrote:
> >> 21 Oca 2007 Paz tarihinde ط¥إ¸unlarط¤ï؟½ yazmط¤ï؟½ط¥إ¸tط¤ï؟½nط¤ï؟½z:
> >>> RSS feed of the git tree:
> >>> http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.gi
> >>>t;a=r
> >>
> >> I already mailed to webmaster _at_ kernel.org 2 days ago but still all
> >> RSS feeds gaves "Internal Server Error"
> >
> > kernel.org is not in quite the best shape currently due to the machines'
> > massive overload, so this may take a little while to get fixed.
>
> Do note that www2.kernel.org has a load that is usually 1/20th of
> www1.kernel.org; apparently due to Microsoft DNS braindamage (which
> affects anyone whose ISP uses MS-DNS.)  Using www2.kernel.org explicitly
> is likely to give you better performance.  HOWEVER, performance is going
> to suck due to the measures we've had to take on the servers regardless,
> and it's entirely likely git-rss is totally broken.  Again, we should
> have a dedicated git server in operation in about a month.

It's rather sad to see kernel.org ppl resort to ms tactics to fix sw problems 
by throwing more hardware into the mess.

My hunch, it's a scheduler problem.  Try spa_no-frills with xfs.


Thanks!

--
Al

