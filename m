Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289493AbSBEMOZ>; Tue, 5 Feb 2002 07:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289481AbSBEMOO>; Tue, 5 Feb 2002 07:14:14 -0500
Received: from [203.199.83.21] ([203.199.83.21]:58344 "HELO
	mailweb9.rediffmail.com") by vger.kernel.org with SMTP
	id <S289380AbSBEMOI> convert rfc822-to-8bit; Tue, 5 Feb 2002 07:14:08 -0500
Date: 5 Feb 2002 12:13:32 -0000
Message-ID: <20020205121332.20718.qmail@mailweb9.rediffmail.com>
MIME-Version: 1.0
From: "Lakshmikantha  A.S" <a_kantha@rediffmail.com>
Reply-To: "Lakshmikantha  A.S" <a_kantha@rediffmail.com>
To: torvalds@transmeta.com, jleu@mindspring.com, linux-kernel@vger.kernel.org,
        linux-kbuild@torque.net
Cc: kaos@ocs.com.au, mec@shout.net
Subject: Hello Sir
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
  I am a M.Sc(Computer Science ) student.Presently I am doing a project 
of "Development of MPLS Based Router".
I am working on Cyrix MediaGXtm MMXtm MMX-S at 233MHz CPU with 128MB RAM on RedHat Linux7.1 on 
Kernel-2.4.2-2. While installing Linux , the system is taken PentiumIII as Processor Type.but after adding the patch and made necessary changes given by the patch and compilation , the system didn't boot and gave the error like 
Kernel panic:the system is compiled for pentium+ 
.........

then i changed the processor type to 586.then it booted properly.

I am using mpls-linux-0.990 for mplsadm utility.Now I enabled 
all the 3 systems with mplsadm by adding the patch and compiling the 
kernel and make mplsadm.

    Before using the mplsadm , 3 systems r pinging each other 
and i was able to make FTP and telnet with all possible combination also.after I use mplsadm commands as given in example of mpls-linux-0.990 for 2 machines
, they r pinging each other.but when i give FTP or telnet to 
remote system , the system in which i gave the ftp or telnet will 
display the error like below and will hang.

[ 2 0r 3 lines r passed in previous screen.so i am not able to give it to u.]

  CPU:0
EIP:0010:[<c023aee2>]
EFLAGS:00010286
eax:0000001c ebx:07d58da0 ecx:00000001 edx:c0322cc4
esi:c7d58dc8 edi:c12b095c ebp:c0301dda esp:c5221b20  

ds:0018  es :0018 ss:0018

Process syslogd (pid:498,stackpage=c5221000)

stack: c02f20cb co2f2340 0000006e c0278ff2 c1291960 0000000e c0278fea ffffffea

c011586e 00000286 00000001 c0388d56 00000002 c479c360 c12915f0 c0301d19

c02791f8 c1291960 c5c1f9e0 c479c360 c5c1f9e0 c12aad30 c12b0060 00000046

Call Trace : [<c02f20cb>] co2f2340 c0278ff2 co278fea c011586e c0301d19 c02791f8

c024fff6 c01c0f62 c0119715 c0261912 c025d14b co23afc6 co25f5co co25c08f

xxxxx xxxxx xxxxx





xxx xxx xxxxx xxx


Code : 0f 0b 83 c4 0c c3 a1 4c 12 39 c0 56 03 05 48 12 39 c0 53 85


Kernel panic:Aiee,killing interrupt handler!
In interrupt handler-not syncing.



-----------------------------------

 I tried with all possible combinations of 3 systems with 2 systems at a time.all the times i am getting the same error.but those numbers will change in different trials.

I tried for 5 or 6 times.I am getting the same problem.
So what may be the reason.Please do suggest some solutions for this.I 
am waiting for solution.because without this I  cant procced further.

SO help me .



With Regards,
Kantha.
  
 

