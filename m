Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSGGQVM>; Sun, 7 Jul 2002 12:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316113AbSGGQVL>; Sun, 7 Jul 2002 12:21:11 -0400
Received: from [192.58.209.91] ([192.58.209.91]:33704 "HELO handhelds.org")
	by vger.kernel.org with SMTP id <S316106AbSGGQVK>;
	Sun, 7 Jul 2002 12:21:10 -0400
From: George France <france@handhelds.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       rmk@arm.linux.org.uk (Russell King)
Subject: Re: [OT] /proc/cpuinfo output from some arch
Date: Sun, 7 Jul 2002 12:25:08 -0400
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
References: <200207070030.g670UbT166497@saturn.cs.uml.edu>
In-Reply-To: <200207070030.g670UbT166497@saturn.cs.uml.edu>
MIME-Version: 1.0
Message-Id: <02070712250804.01900@shadowfax.middleearth>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 July 2002 20:30, Albert D. Cahalan wrote:
>
> Right now I'm looking to get the temperature,
> clock speed, and voltage. I get the first two
> on PowerPC hardware, but it's not obvious what
> mess an SMP system would spit out.
>

Alpha Quad:

cpu                     : Alpha
cpu model               : EV56
cpu variation           : 7
cpu revision            : 0
cpu serial number       :
system type             : Rawhide
system variation        : Dodge
system revision         : 0
system serial number    : BT00000000
cycle frequency [Hz]    : 400000000
timer frequency [Hz]    : 1200.00
page size [bytes]       : 8192
phys. address bits      : 40
max. addr. space #      : 127
BogoMIPS                : 747.36
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 416 (pc=12008d8d0,va=4463)
platform string         : AlphaServer 7310 5/400 4MB
cpus detected           : 4
cpus active             : 4
cpu active mask         : 000000000000000f                                    
  

Intel Quad:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 701.636
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat \pse36 mmx fxsr sse
bogomips        : 1399.19                                                     

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 701.636
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat \pse36 mmx fxsr sse
bogomips        : 1402.47
                                                                              
processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 701.636
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat \pse36 mmx fxsr sse
bogomips        : 1402.47                                                     
            
processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 701.636
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat \pse36 mmx fxsr sse
bogomips        : 1402.47    


Enjoy,


--George

