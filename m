Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319136AbSH2Hni>; Thu, 29 Aug 2002 03:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319139AbSH2Hni>; Thu, 29 Aug 2002 03:43:38 -0400
Received: from ulima.unil.ch ([130.223.144.143]:22933 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S319136AbSH2Hni>;
	Thu, 29 Aug 2002 03:43:38 -0400
Date: Thu, 29 Aug 2002 09:47:59 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Why it would be good to have AC interdiff patches
Message-ID: <20020829074759.GC851@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I know I could do interdiff myself using the patchutils.
I have done it for example for patch-2.4.20-pre4-ac1-ac2.bz2 and it gave
the first reason:

1) patch-2.4.20-pre4-ac1-ac2.bz2 is only 26K (patch-2.4.20-pre4-ac1.bz2
   and patch-2.4.20-pre4-ac2.bz2 are both 1.1M), so as AC kernels are
   very popular, it would reduce bandwight
2) One could more easyly watch what has changed
3) The time for compilation would be smaller as you modify less files.
4) All script on kernel.org are already written for vanilla kernels and
   I am quiete sure it wouldn't be that hard to include the AC...
(5) With my ISDN connection it would be much faster to test those news
   kernels...).

Thank you very much, and in case of response, don't cc to me, receiving
email once is enough ;-)

Have a great day,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
