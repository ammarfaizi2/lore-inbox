Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130599AbRAWO3V>; Tue, 23 Jan 2001 09:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130805AbRAWO3L>; Tue, 23 Jan 2001 09:29:11 -0500
Received: from web11603.mail.yahoo.com ([216.136.172.55]:60938 "HELO
	web11603.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130599AbRAWO3F>; Tue, 23 Jan 2001 09:29:05 -0500
Message-ID: <20010123142904.465.qmail@web11603.mail.yahoo.com>
Date: Tue, 23 Jan 2001 06:29:04 -0800 (PST)
From: Tom <freyason@yahoo.com>
Subject: Re: Proper OOPS report
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Bernd Schmidt <bernds@redhat.com> wrote:
> Details please.
> 
> 
> Bernd

Processor:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.034
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 897.84

When the OOPS happened, I was in X (3.3.6, not 4) and I had up on my
screen 2 Eterms, xmms, and Netscape. The OOPS took out Netscape and
xmms. Nothing else was touched.

Sound card:  Soundblaster AWE64 Gold  (using standard OSS modules)

Tom

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices. 
http://auctions.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
