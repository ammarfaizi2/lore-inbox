Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKNPEc>; Tue, 14 Nov 2000 10:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbQKNPEM>; Tue, 14 Nov 2000 10:04:12 -0500
Received: from mx3.port.ru ([194.67.23.37]:48911 "EHLO mx3.port.ru")
	by vger.kernel.org with ESMTP id <S129103AbQKNPEI>;
	Tue, 14 Nov 2000 10:04:08 -0500
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: RE: /proc tweaking
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.30.66]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E13vh9C-0001mM-00@f6.mail.ru>
Date: Tue, 14 Nov 2000 17:33:23 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on Tue, 14 Nov 2000 Arjan van de Ven wrote:
>In article <E13vevy-0003Lv-00@f4.mail.ru> you wrote:
>>            Hey people, i`ve got such a thought
>>     not long ago:
>>       all boxes are different, but the /proc/sys/vm
>>       defaults are equal for every people, so there
>>       is a good issue in getting more performance
>>       from linux, just by making a way to autoadjust
>>       these mysterious values according to amount of
>>       RAM/swap and speed of CPU!  Or this can be >done
>>       in userspace with an utility which look also
>>       on the field of box` use (eg workstation, >>server        etc...)
>>           But who can make this better than the >>people        who hack the kernel?
>>           And i wonder why such a issue is not >>clearly        covered? (maybe
>>i`m making mistake?)
>>           This can also be done for >>proc/sys/net/*...
>
>
>Take a look at powertweak. >http://powertweak.sourceforge.net
>Made by kernel people, for non-kernel people.

      Maybe i were not enough exact, but i`ve meant
   addition of some intelligence to tweaking /proc
   e.g. something what automates tuning, not only
   providing interface to such actions.
      But after lookthru ptweaks source i realized
   what its ONLY interface (to proc), and MAYBE
   it does some PCI tuning (really intelligent 
   choices to advance system`s performance).
      BTW powertweak is a port from unfamous MD,
   therefore when it was created NO proc tuning
   was in mind...

      There is another argument, telling what doing        autotune is ugly by design.... but thats another        issue.

   Sorry for poor english/lameness


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
