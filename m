Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUBHM5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 07:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbUBHM5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 07:57:38 -0500
Received: from www1.mail.lycos.com ([209.202.220.140]:64973 "HELO lycos.com")
	by vger.kernel.org with SMTP id S263564AbUBHM5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 07:57:36 -0500
To: linux-kernel@vger.kernel.org
Date: Sun, 08 Feb 2004 17:57:23 +0500
From: "vishwas manral" <vishwas.manral@lycos.com>
Message-ID: <EONKHGJGJIKGHIAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: off
Reply-To: vishwas.manral@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Re: Fwd: Newbie: Unresolved symbol
X-Sender-Ip: 61.95.163.161
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore my earlier mail. I was able to resolve it myself.

-Vishwas
--------- Original Message ---------

DATE: Sun, 08 Feb 2004 16:56:17
From: "vishwas manral" <vishwas.manral@lycos.com>
To: linux-kernel@vger.kernel.org
Cc: 

>Hi, 
>
>Posted the below to the newbie list got no response. Any help would be appriciated.
>
>Also wanted to add that /proc/ksyms seemed to have all the symbols required.
>
>Thanks,
>Vishwas
>--------- Forwarded Message ---------
>
>DATE: Sun, 08 Feb 2004 16:06:18
>From: "vishwas manral" <vishwas.manral@lycos.com>
>To: vishwas.manral@lycos.com
>Cc: kernelnewbies@nl.linux.org
>
>Hi folks,
>
>I had built and inserted my kernel module, I wanted to debug and I made some changes. Now after removing the old module I am not able to insert the new module at all.
>
>I am inserting the module in the development machine itself so no version mismatches. I tried adding and removing other modules and that works fine. 
>
>The below seem to be all the symbols I am using in my module. Any hint what I may have accidently removed or deleted or what I am missing would be helpful.
>
>krn_mod.o: unresolved symbol pci_write_config_byte
>krn_mod.o: unresolved symbol __generic_copy_from_user
>krn_mod.o: unresolved symbol kmalloc
>krn_mod.o: unresolved symbol unregister_chrdev
>krn_mod.o: unresolved symbol register_chrdev
>krn_mod.o: unresolved symbol pci_read_config_byte
>krn_mod.o: unresolved symbol pcibios_present
>krn_mod.o: unresolved symbol pci_read_config_dword
>krn_mod.o: unresolved symbol __ioremap
>krn_mod.o: unresolved symbol pci_read_config_word
>krn_mod.o: unresolved symbol kfree
>krn_mod.o: unresolved symbol pci_write_config_dword
>krn_mod.o: unresolved symbol pci_find_device
>krn_mod.o: unresolved symbol pci_write_config_word
>krn_mod.o: unresolved symbol printk
>krn_mod.o: unresolved symbol __generic_copy_to_user
>
>Thanks,
>Vishwas
>
>
>
>____________________________________________________________
>Find what you are looking for with the Lycos Yellow Pages
>http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.asp?SRC=lycos10
>
>--------- End Forwarded Message ---------
>
>
>
>
>____________________________________________________________
>Find what you are looking for with the Lycos Yellow Pages
>http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.asp?SRC=lycos10
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



____________________________________________________________
Find what you are looking for with the Lycos Yellow Pages
http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.asp?SRC=lycos10
