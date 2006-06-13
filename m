Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWFMXdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWFMXdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWFMXdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:33:11 -0400
Received: from vodka.checkgiant.com ([63.247.91.138]:28836 "EHLO
	vodka.checkgiant.com") by vger.kernel.org with ESMTP
	id S964802AbWFMXdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:33:09 -0400
From: "Scott Lockwood" <lkml@lrsehosting.com>
To: "'Kyle Moffett'" <mrmacman_g4@mac.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: VGER does gradual SPF activation (FAQ matter)
Date: Tue, 13 Jun 2006 18:32:54 -0500
Message-ID: <001801c68f41$b3cd24d0$290ee00a@wshq41>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcaPPuIOaJu1lPSuT4uu87MbnJxovgAArxkw
In-Reply-To: <AC44C19E-109F-4DD4-933E-B641BF3BF9CB@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So get a better ISP than cox.net. 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Kyle Moffett
Sent: Monday, June 12, 2006 6:42 AM
To: Bernd Petrovitsch
Cc: David Schwartz; LKML Kernel; jdow
Subject: Re: VGER does gradual SPF activation (FAQ matter)

On Jun 12, 2006, at 04:18:06, Bernd Petrovitsch wrote:
> No. SPF simply defines legitimate outgoing MTAs for a given domain.

I'm sorry, but the internet just doesn't work that way.  I have 3 email
accounts (mac.com, vt.edu, and cox.net).  Both my college and my house deny
all SMTP to anyone but their local servers.  If mac.com published an SPF
filter and VGER used the SPF filter, I would have no way at all to send mail
via this account, simply for the reason that neither of my local ISPs will
allow my to directly send email to mac.com.  Likewise for my vt.edu account
while at home or my cox.net account while at college.

IMHO, turning on SPF will not gain anything for the LKML; a bayesian filter
based solution would be much more tenable.

Cheers,
Kyle Moffett

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

