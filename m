Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTLARk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 12:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263873AbTLARk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 12:40:26 -0500
Received: from imag.imag.fr ([129.88.30.1]:64751 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S263871AbTLARkY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 12:40:24 -0500
Date: Mon, 1 Dec 2003 18:43:16 +0100
Mime-Version: 1.0 (Apple Message framework v551)
Content-Type: text/plain; delsp=yes; charset=ISO-8859-1; format=flowed
Subject: a few question on threads affinity and CPU shielding.
From: =?ISO-8859-1?Q?Nicolas_Castagn=E9?= <nicolas.castagne@imag.fr>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D7F95611-2425-11D8-9C79-000393C76CA6@imag.fr>
X-Mailer: Apple Mail (2.551)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I  was very pleased that some patches for controlling CPU affinities  
were merged in the 2.5 (and 2.6) releases of the kernel.

Where may I find precisions on the patches that are now included ?

Especially, with the 2.6 release :
- is it possible to control the cpu affinity of threads (as for  
processes) ?
- is there also a patch to shield cpu against the scheduler ?
- is there also a patch to shield cpu against all interruptions  
(especially hard clock interrups) ?

We here are (very) used to SGI IRIX real time facilities, but also very  
new to linux.
We plan on porting our hard-real-time applications for multisensorial  
simulation on linux. These questions are very important to us.

Thx a lot in advance,
and please believe I am VERY sorry if this is not the correct list for  
my questions, and if I disturbed serious work ;-).
If so, please let me know !

Nicolas
------------------------------------------------------------------------ 
--------------------------
Dr Nicolas CASTAGNE
Researcher, IR de l'ACROE / ICA,

Association pour la Création et la Recherche
	sur les Outils d'Expression
Laboratoire Informatique et Création Artistique
INPG,
46 av. F. Viallet, 38000 Grenoble, France.

pro : (33) 4 76 57 46 60
fax : (33) 4 76 57 48 89
------------------------------------------------------------------------ 
--------------------------

