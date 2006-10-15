Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWJOWP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWJOWP7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 18:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWJOWP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 18:15:59 -0400
Received: from main.gmane.org ([80.91.229.2]:40352 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932141AbWJOWP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 18:15:58 -0400
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: Steve Youngs <steve@youngs.au.com>
Subject: Re: Bad core files with 2.6.19-rc2
Date: Mon, 16 Oct 2006 08:15:33 +1000
Organization: Linux Users - Fanatics Dept.
Message-ID: <microsoft-free.87ejt9gr96.fsf@youngs.au.com>
References: <microsoft-free.87mz7yjnm2.fsf@youngs.au.com>
	<20061015184217.GZ30596@stusta.de> <45328AF9.7060807@vandrovec.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
Keywords: fixed
X-Gmane-NNTP-Posting-Host: 203-206-170-37.perm.iinet.net.au
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Mail-Copies-To: never
X-X-Day: Only 2430587 days till X-Day.  Got Slack?
X-URL: <http://www.youngs.au.com/~steve/>
X-Request-PGP: <http://www.youngs.au.com/~steve/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Now-Playing: The Sounds of Silence --- [Marcel Marceau]
X-Discordian-Date: Prickle-Prickle, the 70th day of Bureaucracy, 3172. 
X-Attribution: SY
User-Agent: Gnus/5.110006 (No Gnus v0.6) SXEmacs/22.1.6 (Cadillac, linux)
Cancel-Lock: sha1:Ul+MTnl8m8VOHjAx1ycaEWwJrGQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Petr Vandrovec <petr@vandrovec.name> writes:

  > Adrian Bunk wrote:
  >> On Sun, Oct 15, 2006 at 12:53:41PM +1000, Steve Youngs wrote:
  >>> warning: Couldn't find general-purpose registers in core file.
  >>> #0  0x00000000 in ?? ()

  >> It seems this issue should be fixed in Linus' tree now.
  >> 
  >> Can you confirm it's fixed?

  > It should be fixed now

Yes, it is.  Thank you very much.

-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|                   Te audire no possum.                   |
|             Musa sapientum fixa est in aure.             |
|----------------------------------<steve@youngs.au.com>---|

