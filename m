Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267456AbTB1EJv>; Thu, 27 Feb 2003 23:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbTB1EJv>; Thu, 27 Feb 2003 23:09:51 -0500
Received: from [213.140.2.50] ([213.140.2.50]:31728 "EHLO
	mailres.fastwebnet.it") by vger.kernel.org with ESMTP
	id <S267456AbTB1EJv>; Thu, 27 Feb 2003 23:09:51 -0500
Subject: master needed... for a CardBUS card
From: alx <alexs81@libero.it>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 Feb 2003 05:20:05 +0100
Message-Id: <1046406005.26603.72.camel@galileo.homenet.lan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all
	I'm new in kernel programming so I'm asking for someone who can drive
me (not to code instead of me, just suggest the right direction).
I'm gonna writing a module for a PCMCIA card that has the TI acx100 chip
It is a WiFi Ethernet card and there is no datasheet for it.

TIA
Alx

-- 
int a=10000,b,c=2800,d,e,f[2801],g;main(){for(;b-c;) f[b++]=a/5;
for(;d=0,g=c*2;c-=14,printf("%.4d",e+d/a),e=d%a)for(b=c;d+=f[b]*a,
f[b]=d%--g,d/=g--,--b;d*=b);}

