Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbTJGN67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTJGN66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:58:58 -0400
Received: from www02.ies.inet6.fr ([62.210.153.202]:13963 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S262351AbTJGN65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:58:57 -0400
Message-ID: <3F82C69E.5060609@inet6.fr>
Date: Tue, 07 Oct 2003 15:58:54 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE errors with 2.6.0-test* and SIS5513
References: <20031006193401.GA30170@irq.dk>
In-Reply-To: <20031006193401.GA30170@irq.dk>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Kjær said the following on 10/06/2003 09:34 PM:

>Hi!
>
>I'm having problems with the 2.6 kernels and the SIS5513 IDE chipset.
>
>  
>

Does kernel parameter noapic change anything ?

Could you attach your .config file and the output of lspci -vvxxx ?

Best regards,

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
/ /\  /_  / /_   France
\/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10




