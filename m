Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287595AbSALWMS>; Sat, 12 Jan 2002 17:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287593AbSALWMG>; Sat, 12 Jan 2002 17:12:06 -0500
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:58612 "HELO
	dardhal") by vger.kernel.org with SMTP id <S287588AbSALWLy>;
	Sat, 12 Jan 2002 17:11:54 -0500
Date: Sat, 12 Jan 2002 23:11:45 +0100
From: Jose Luis Domingo Lopez <jdomingo@internautas.org>
To: Tony Glader <Tony.Glader@blueberrysolutions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: F00F-bug workaround working?
Message-ID: <20020112221144.GC1406@localhost>
Mail-Followup-To: Tony Glader <Tony.Glader@blueberrysolutions.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201122347270.16871-100000@blueberrysolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0201122347270.16871-100000@blueberrysolutions.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 12 January 2002, at 23:49:06 +0200,
Tony Glader wrote:

> I have had problems with 2.4.17 running in a Classic Pentium (lot of 
> oopses). I'm sure that there's no problem with hardware. Is F00F'bug 
> workaround work still?
> 
No problems here with any 2.4.x kernel, both with old and new
workarounds for the mentioned bug.

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 12
cpu MHz		: 165.792
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8
bogomips	: 330.95

Jan 12 12:30:21 dardhal kernel: Intel Pentium with F0 0F bug -
workaround enabled

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

