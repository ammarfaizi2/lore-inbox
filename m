Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbTJTPRV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 11:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTJTPRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 11:17:20 -0400
Received: from www02.ies.inet6.fr ([62.210.153.202]:20114 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S262587AbTJTPRT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 11:17:19 -0400
Message-ID: <3F93FC7C.2090606@inet6.fr>
Date: Mon, 20 Oct 2003 17:17:16 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: konsti@ludenkalle.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Uncorrectable Error on IDE, significant accumulation
References: <20031020132705.GA1171@synertronixx3> <E1ABaqY-0000jn-NG@rhn.tartu-labor> <20031020145316.GB593@synertronixx3>
In-Reply-To: <20031020145316.GB593@synertronixx3>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Kletschke wrote the following on 10/20/2003 04:53 PM :

>Can a bad Powersupply or weak mainboard create Uncorrectable Errors on
>HDDs? Again only a question to experience of this community...
>  
>

It certainly can temporarily (under load).

Try offloading some power strain by removing some peripherals (CD-ROM, 
non-mandatory disk drive) and see if it solves your problem.

I might be mistaken (don't know the exact behavior of drive electronics) 
but it seems unlikely that a bad PSU with underrated voltage could 
damage a drive (overrated voltage is another matter). Usually under spec 
PSUs fail to produce enough juice under load and the system simply 
becomes unstable.

Best regards,

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 


