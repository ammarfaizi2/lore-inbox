Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280872AbRKLSGJ>; Mon, 12 Nov 2001 13:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280902AbRKLSF7>; Mon, 12 Nov 2001 13:05:59 -0500
Received: from femail3.sdc1.sfba.home.com ([24.0.95.83]:52611 "EHLO
	femail3.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S280872AbRKLSFl>; Mon, 12 Nov 2001 13:05:41 -0500
Date: Mon, 12 Nov 2001 13:05:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15pre1-Oops with netfilter
Message-ID: <20011112130539.A17339@cy599856-a.home.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BEFE601.4050808@korseby.net> <001f01c16b92$a54cb6f0$9865fea9@pcsn630778>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001f01c16b92$a54cb6f0$9865fea9@pcsn630778>
User-Agent: Mutt/1.3.23i
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.4.15-pre3 i586 K6-3+
X-Uptime: 13:04:25 up 11:07,  3 users,  load average: 0.00, 0.00, 0.02
From: Josh McKinney <forming@home.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Mon, Nov 12, 2001 at 10:56:52AM -0500, Alok K. Dhir wrote:
> This is likely the same bug that I and a few others on this list
> experienced.  Back out the 4 netfilter patches which went into -pre1 and
> it should work again.
> 
> Look for the message with the subject "Confirm netfilter: repeatable
> oops in 2.4.15-pre2" in the archives and it has the patches attached
> which you should reverse apply to your tree.
> 

2.4.15-pre3 also fixes the problem.

Josh
-- 
Linux, the choice                | Life is like a diaper -- short and loaded. 
of a GNU generation       -o)    | 
Kernel 2.4.15-pre3         /\    | 
on a i586                 _\_v   | 
                                 | 
