Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAKXbk>; Thu, 11 Jan 2001 18:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbRAKXbV>; Thu, 11 Jan 2001 18:31:21 -0500
Received: from fes-qout.whowhere.com ([209.185.123.96]:62350 "HELO
	mailcity.com") by vger.kernel.org with SMTP id <S129631AbRAKXbQ>;
	Thu, 11 Jan 2001 18:31:16 -0500
To: linux-kernel@vger.kernel.org
Date: Thu, 11 Jan 2001 18:30:47 -0500
From: "Gregg Lloyd" <gregg_99@lycos.com>
Message-ID: <HKPKHOJMBOBKGAAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: on
Reply-To: gregg_99@mailcity.com
X-Mailer: MailCity Service
Subject: Cannot compile my kernel due to unpredictible situations: 
X-Sender-Ip: 198.133.22.72
Organization: Lycos Communications  (http://comm.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have downloaded linux kernel 2.4. 
In /usr/src, I did untar the file: 
gzip -cd  linux-2.4.0.tar.gz  | tar xvf - 
I see several files being copied to several locations (/linux/Documentation, 
/linux/arch/..etc..). The problem is that there's no linux 2.4   directory created 
under /usr/src or anywhere else on my system! Anyway, there's nothing new 
under /usr/src!!! 
Linux is not new to me, so I know that this is weird ( I even tried it with  "tar -zxvf  linux-2.4.0.tar.gz", "gzcat  linux-2.4.0.tar.gz | tar xvf - " ..etc). Same result. 
Anyway, let's say that it doesn't matter whether there's a new kernel 2.4 directory or not..
how can I make sure that I  am  re-compiling my kernel (currently kernel 2.2.5) with 
the right 2.4 kernel?? (Kernel howto talks about going to /usr/src/linux and start compiling..but current /usr/src/linux is a link to my current 2.2.5 kernel !!!)

Current OS: Red Hat Linux 6.0 Kernel 2.2.5

Thanks



Get your small business started at Lycos Small Business at http://www.lycos.com/business/mail.html
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
