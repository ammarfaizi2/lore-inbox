Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTJTPIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 11:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbTJTPIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 11:08:18 -0400
Received: from www01.ies.inet6.fr ([62.210.153.201]:8646 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S262569AbTJTPIR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 11:08:17 -0400
Message-ID: <3F93FA5E.2020300@inet6.fr>
Date: Mon, 20 Oct 2003 17:08:14 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: konsti@ludenkalle.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Uncorrectable Error on IDE, significant accumulation
References: <20031020132705.GA1171@synertronixx3> <3F93E728.5050908@inet6.fr> <20031020144822.GA593@synertronixx3>
In-Reply-To: <20031020144822.GA593@synertronixx3>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Kletschke wrote the following on 10/20/2003 04:48 PM :

>
>Hm, I have the Board Revision whih also remembers its BIOS Settings once
>after a while (once per month or so). Does that also belong to
>"electrical defects"?
>  
>

Maybe... do you mean your CMOS settings are periodically reset ? In this 
case it usually is simply a worn-out battery.

>So should I buy a K7S5A Pro now. It eats my old school SDRAM, thats
>why...
>  
>

K7S5A Pro are dirt cheap these days, so it might be a good idea to buy a 
new one.

For the record, reallocated sectors are quite common with modern disks, 
I had some (3-4) on a one-year old 120Go Maxtor but the drive worked 
perfectly. You should install the smartmontools and run smartd 
configured to send you an e-mail each time a new defect is found. You 
have then one more opportunity to anticipate a drive going to fail by 
backuping and restoring on another drive.

Best regards,

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 


