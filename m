Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSEZTCA>; Sun, 26 May 2002 15:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316301AbSEZTB7>; Sun, 26 May 2002 15:01:59 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:57992 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S316300AbSEZTB6>; Sun, 26 May 2002 15:01:58 -0400
Date: Sun, 26 May 2002 14:01:58 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: jay <jbeatty@optonline.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: usb mass storage  fails in 2.5.18
Message-ID: <20020526140157.A24125@ksu.edu>
Mail-Followup-To: jay <jbeatty@optonline.net>,
	linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CF12EE3.6070609@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-School: Kansas State University
X-vi-or-emacs: vi
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've also had problems with 2.5.17 (haven't tested 2.5.18) and a USB
  ZIP drive (Zip 250 USB-powered).  It looks like a write operation times
  out, and the drive keeps getting reassigned new USB device numbers.  I
  can provide more info if anyone's interested.  I *do* recall that it's
  something like bulk_write, and it fails with error -110.

-Joseph
-- 
Joseph======================================================jap3003@ksu.edu
[While discussing 8 new IIS (Microsoft's webserver) vulnerabilities]
"One workaround we rather like is called Apache, but we digress...."
  Greene, The Register, http://www.theregister.co.uk./content/4/24795.html
