Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135737AbRD2QRh>; Sun, 29 Apr 2001 12:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135809AbRD2QR1>; Sun, 29 Apr 2001 12:17:27 -0400
Received: from smtp.sunflower.com ([24.124.0.137]:57612 "EHLO
	smtp.sunflower.com") by vger.kernel.org with ESMTP
	id <S135737AbRD2QRT>; Sun, 29 Apr 2001 12:17:19 -0400
From: "Steve 'Denali' McKnelly" <denali@sunflower.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: "Matthias Andree" <matthias.andree@stud.uni-dortmund.de>,
        "Linux-Kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Date: Sun, 29 Apr 2001 11:17:14 -0500
Message-ID: <PGEDKPCOHCLFJBPJPLNMCEDOCMAA.denali@sunflower.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20010429122546.A1419@werewolf.able.es>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy J.A.,

	Let me ask a possibly stupid question... How do you tell
what version of the Gibbs Adaptec driver you're using?  Did I
misunderstand you when you said the 2.4.4 kernel is using 6.1.5?
Also, did I understand you to say the 6.1.12 version will fix
my unresolved symbol problem?

Thanks,
Steve

-----Original Message-----
From: J . A . Magallon [mailto:jamagallon@able.es]
Sent: Sunday, April 29, 2001 5:26 AM
To: Steve 'Denali' McKnelly
Cc: Matthias Andree; Linux-Kernel mailing list
Subject: Re: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect
sda



On 04.29 Steve 'Denali' McKnelly wrote:
>              Command found on device queue
> aic7xxx_abort returns 8194
>

I have seen blaming for this error to aic7xxx new driver prior to version
6.1.11. It was included in the 2.4.3-ac series, but its has not got into
main 2.4.4 (there is still 6.1.5). Everything needs its time.

Grab the updated patch from people.freebsd.org/~gibbs/linux.

BTW (Alan?) new version is 6.1.12 (just patched 2.4.4 after offset
engineering and works fine).
Candidate for 2.4.4-ac1 or 2.4.5-pre1 ?

--
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you,
Luke...

Linux werewolf 2.4.4 #1 SMP Sat Apr 28 11:45:02 CEST 2001 i686

