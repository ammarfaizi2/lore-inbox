Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267403AbUH1J6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUH1J6G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267435AbUH1J5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:57:30 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:59290 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S267403AbUH1JxT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:53:19 -0400
Date: Sat, 28 Aug 2004 09:53:07 +0000 (UTC)
From: dulle <dulle@free.fr>
Reply-To: dulle@free.fr
To: linux-kernel@vger.kernel.org
Message-ID: <Pine.LNX.4.60.0408280858090.1577@ganymede.chateauneuf.fr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1502480738-1093683503=:1577"
Content-ID: <Pine.LNX.4.60.0408280908160.1609@ganymede.chateauneuf.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811839-1502480738-1093683503=:1577
Content-Type: TEXT/PLAIN; CHARSET=X-UNKNOWN; FORMAT=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.60.0408280908161.1609@ganymede.chateauneuf.fr>


Craig Milo Rogers wrote:

>       Hmmm... a poster on Slashdot claims that entropy measurements
>imply that the pwcx code is interpolating rather that truly
>decompressing.

That  is  clearly  false.   Amateur   astronomers   have
extensively used the pwc  webcams  for  years  now,  and
these type of applications is most demanding in term  of
resolution. And amateur astronomers  know  what  CCD  is
about, and would not be fooled by such a flaw.

Moreover the CCD chip inside philips cameras  (at  least
those using a CCD and not a CMOS) is a (roughly) 640x480
chip (sony ICX098) http://www.sony.co.jp/~semicon/japan-
ese/img/sonyj01/e6803249.pdf that probably costs 5 or  6
times the price of a 160x120 chip.

These cams do have a 640x480 chip and process images  in
consequence, slashdot or not.

And their hardware is extremely robust and efficient.

Also as a not uninterested user, and a bit off-topic,  I
just want to underline the impact that those webcams and
pwc may have in totally unexpected domains, making  them
far more than just gadgets.

The quality  of  those  webcams  by  Philips  (and  some
others), and the versatility of the pwc  driver  have  a
leading role in the  -real-  revolution  that  planetary
astronomical  imaging   has   experienced   since   they
appeared. A simple web search  on  'webcam'  and  either
'jupiter', 'saturn', 'mars' will confirm that for a  few
years these gadgets  have  outperformed  (for  different
reasons) specialized astronomical CCD  cameras  (costing
20, 50 or 100 times more)  in  that  particular  domain.
(just check
http://www.ort.cuhk.edu.hk/ericng/webcam/planets.htm
for some jaw-dropping shots)

The  amateur  astronomer  community  has  had   valuable
exchange with Nemosoft in order to get the best of these
devices, and the result is a typical example of what can
be achieved when combining new  ideas  and  open  source
projects.

Regards
-- Fran=E7ois Meyer
---1463811839-1502480738-1093683503=:1577--
