Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292530AbSCRKyq>; Mon, 18 Mar 2002 05:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292599AbSCRKyh>; Mon, 18 Mar 2002 05:54:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17897 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S292530AbSCRKyb>;
	Mon, 18 Mar 2002 05:54:31 -0500
Date: Mon, 18 Mar 2002 11:53:51 +0100
From: KELEMEN Peter <fuji@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [2.4.19pre3] Celeron 333 MMX hangs w/MCE upon boot
Message-ID: <20020318105351.GA27739@chiara.elte.hu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.27i
Organization: ELTE Eotvos Lorand University of Sciences, Budapest, Hungary
X-GPG-KeyID: 1024D/EE4C26E8 2000-03-20
X-GPG-Fingerprint: D402 4AF3 7488 165B CC34  4147 7F0C D922 EE4C 26E8
X-PGP-KeyID: 1024/45F83E45 1998/04/04
X-PGP-Fingerprint: 26 87 63 4B 07 28 1F AD  6D AA B5 8A D6 03 0F BF
X-Comment: Personal opinion.  Paragraphs might have been reformatted.
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Accept-Language: hu,en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My Intel Celeron 333 MMX hangs upon boot if MCE is enabled (kernel
2.4.19pre3).  /proc/cpuinfo follows:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 0
cpu MHz         : 333.466
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 665.19

Are there any issues I missed?

Peter

-- 
    .+'''+.         .+'''+.         .+'''+.         .+'''+.         .+''
 Kelemen Péter     /       \       /       \       /      fuji@elte.hu
.+'         `+...+'         `+...+'         `+...+'         `+...+'
