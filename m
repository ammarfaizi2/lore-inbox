Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279522AbRJXKmV>; Wed, 24 Oct 2001 06:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279521AbRJXKmL>; Wed, 24 Oct 2001 06:42:11 -0400
Received: from inje.iskon.hr ([213.191.128.16]:36566 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S279522AbRJXKl5>;
	Wed, 24 Oct 2001 06:41:57 -0400
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: xmm2 - monitor Linux MM active/inactive lists graphically
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 24 Oct 2001 12:42:26 +0200
Message-ID: <8766959v59.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New version is out and can be found at the same URL:

<URL:http://linux.inet.hr/>

As Linus' MM lost inactive dirty/clean lists in favour of just one
inactive list, the application needed to be modified to support that.

You can still continue to use the older one for kernels <= 2.4.9
and/or Alan's (-ac) kernels, which continued to use older Rik's VM
system.

Enjoy and, as usual, all comments welcome!
-- 
Zlatko

P.S. BTW, 2.4.13 still has very unoptimal writeout performance and
     andrea@suse.de is redirected to /dev/null. <g>
