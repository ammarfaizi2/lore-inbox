Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273911AbRIXN6H>; Mon, 24 Sep 2001 09:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273912AbRIXN56>; Mon, 24 Sep 2001 09:57:58 -0400
Received: from ginsberg.uol.com.br ([200.231.206.26]:15790 "EHLO
	ginsberg.uol.com.br") by vger.kernel.org with ESMTP
	id <S273911AbRIXN5y>; Mon, 24 Sep 2001 09:57:54 -0400
Message-ID: <3BAF3C3C.2060108@uol.com.br>
Date: Mon, 24 Sep 2001 10:59:24 -0300
From: "Michel A. S. Pereira KIDMumU|ResolveBucha" 
	<michelcultivo@uol.com.br>
Organization: TECHS Provider
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: pt-br, en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.10 and ACPI
In-Reply-To: <F138NIPukg3nOpj53Xa000046c3@hotmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi, I was getting a different problem with ACPI.
	When the Kernel ends enabling ACPI, the machine hangs, and 
Control+Alt+Del dosen't run.
	Why I can do to get more details about this problem?

Thanks and sorry for the bad english.


Rob MacGregor wrote:

> I should mention that I get exactly the same result from 2.4.9.  I 
> hadn't tried ACPI before then.
> 
> On both my desktop (based on a SuperMicro P6DGU with the Intel 440GX 
> chipset, l) and my laptop (HP Omnibook 450B) when I build in the ACPI 
> system (either as module or into the kernel) the system hangs on boot.  
> It does this at the point of activating ACPI.  I enabled the debug mode 
> and my laptop dies at:
> 
> ACPI Namespace successfully loaded at root c028a6c0
> ACPI: Core Subsystem version [20010831]
> Executing device _INI methods:.....................
> 
> (that's 21 '.'s).
> 
> Is there anything else I can do to help track down what's causing this 
> and resolve it?
> 
> I'm not on the list (though I should start getting the daily digest as 
> of today) so you'll need to CC me if you want me to see anything.
> 
> -- 
> Rob  |  Please ask questions the smart way:
>                http://www.tuxedo.org/~esr/faqs/smart-questions.html
> 
>    Please don't CC me on anything sent to mailing lists or send
>        me email directly unless it's a privacy issue, thanks.
> 
> 
> _________________________________________________________________
> Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



-- 
============================================================
|P4 1.3GHz - 128MB RAM - HD 30GB - Diammond Savage4
|Conectiva Linux 7.0 - Kernel 2.4.9
|www.techs.com.br/kidmumu - UIN 4553082 - LC 83522
|Powered by Fanta Uva, suco de Acerola e Passatempo Recheada
|Jesus está voltando, você está preparado?
============================================================

