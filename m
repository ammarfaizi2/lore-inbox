Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbTLSMzu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTLSMyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:54:43 -0500
Received: from www01.ies.inet6.fr ([62.210.153.201]:53438 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S263062AbTLSMcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:32:24 -0500
Message-ID: <3FE2EFD5.6000009@inet6.fr>
Date: Fri, 19 Dec 2003 13:32:21 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Hunt <ojh16@student.canterbury.ac.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE issues
References: <3FE43492.3020703@student.canterbury.ac.nz>
In-Reply-To: <3FE43492.3020703@student.canterbury.ac.nz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Hunt wrote the following on 12/20/2003 12:37 PM :

> I was using 2.6.0-test11 on a gentoo install on this system and my 
> system worked fine, however that install died earlier this week, and 
> now i'm running debian.  The configuration in gentoo didn't boot for 
> debian so i reset everything from scratch.
>
> [...]


>CONFIG_BLK_DEV_SIS5513=y
>  
>
Might be either a too old kernel version without proper support for your 
SiS chipset or shaky local APIC support.
I suppose you use a 2.4 kernel with debian. Which version is it ?
What is the chipset (or the motherboard) model ?

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 

