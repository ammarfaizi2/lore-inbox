Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272592AbRIOTaL>; Sat, 15 Sep 2001 15:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273012AbRIOTaB>; Sat, 15 Sep 2001 15:30:01 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:32529 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S272592AbRIOT3t>; Sat, 15 Sep 2001 15:29:49 -0400
Message-ID: <3BA228EA.FCD61CA1@eisenstein.dk>
Date: Fri, 14 Sep 2001 17:57:30 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AGP GART for AMD 761
In-Reply-To: <1000577021.32706.29.camel@phantasy> 
		<3BA22537.94D4EA28@eisenstein.dk> <1000582067.32708.51.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> Please type `/sbin/lspci -n -v -s 0:0' and give me the results.

bash-2.05# /sbin/lspci -n -v -s 0:0
00:00.0 Class 0600: 1022:700e (rev 13)
        Flags: bus master, medium devsel, latency 32
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Memory at f7800000 (32-bit, prefetchable) [size=4K]
        I/O ports at e000 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0


Best regards,
Jesper Juhl
juhl@eisenstein.dk


