Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVGKWkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVGKWkt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVGKWkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:40:35 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:50843 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262042AbVGKWkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:40:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=xCDKlDYVTKI/hNxzZxBrT6rWRFXtWla1tgA0DCx43e5w/VtT0BUkOJCg9KAYNRXP5p7Enamz+CeFrda2IWfFae0Ytiuz4bZloouz+RCZMzhRt+ybNUmJinVFxoTahlNr8akl78pg+IVjsqIdVbU7Ty4EoB1kRnQ3fa6qktd5t+o=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Peter <peter.spamcatcher@rimuhosting.com>
Subject: Re: unregister_netdevice: waiting for tap24 to become free
Date: Tue, 12 Jul 2005 00:47:32 +0200
User-Agent: KMail/1.8.1
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050709110143.D59181E9EA4@zion.home.lan> <200507120020.52418.blaisorblade@yahoo.it> <42D2F22C.3060102@rimuhosting.com>
In-Reply-To: <42D2F22C.3060102@rimuhosting.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507120047.33064.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 July 2005 00:26, Peter wrote:
> Nothing in the logs prior to the first error message.
>
> I've hit this before at different times on other servers.  If there are
> some commands I can run to gather more diagnostics on the problem,
> please let me know and I'll capture more information next time.
>
> I see the error was reported with older 2.6 kernels and a patch was
> floating around.  I'm not sure if that is integrated into the current
> 2.6.11 kernel.
The patch named there has been integrated, verifyable at 
http://linux.bkbits.net:8080/linux-2.6/cset@4129735fMSVl0_RA4uNcNBWHFjT-zw

However this time the bug is probably due to something entirely different, the 
message is not very specific.

Tried 2.6.12? SKAS has been already updated (plus there's an important update 
for SKAS, from -V8 to -V8.2).
> http://www.google.com/search?q=unregister_netdevice%3A+waiting
>
> Regards, Peter

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
