Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317915AbSGWAjB>; Mon, 22 Jul 2002 20:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317908AbSGWAiB>; Mon, 22 Jul 2002 20:38:01 -0400
Received: from emory.viawest.net ([216.87.64.6]:13003 "EHLO emory.viawest.net")
	by vger.kernel.org with ESMTP id <S317881AbSGWAgp>;
	Mon, 22 Jul 2002 20:36:45 -0400
Date: Mon, 22 Jul 2002 17:39:09 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
Message-ID: <20020723003909.GA18594@wizard.com>
References: <Pine.SOL.4.30.0207222130040.27373-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0207222130040.27373-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.25 (i686)
X-uptime: 5:33pm  up 1 day, 30 min,  2 users,  load average: 0.00, 0.02, 0.00
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 09:37:13PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> IDE 99 which is included in 2.5.27 introduced really nasty bug.
> Possible lockups and data corruption. Please do not.
> 
> Regards
> --
> Bartlomiej

        Okay.. I have to ask the question.. Which version of IDE does 2.5.27 
have? you're saying IDE 99. According to the changelog Linus threw out with 
2.5.27:

Martin Dalecki <dalecki@evision-ventures.com>:
  o 2.5.26 IDE 99
  o IDE 100

        With this, I'm assuming 2.5.27 has IDE 100 in it, patched up from IDE 
99. Correct me if I'm wrong.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

