Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbREZRiE>; Sat, 26 May 2001 13:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbREZRhy>; Sat, 26 May 2001 13:37:54 -0400
Received: from [213.96.224.204] ([213.96.224.204]:1796 "HELO manty.net")
	by vger.kernel.org with SMTP id <S261594AbREZRhr>;
	Sat, 26 May 2001 13:37:47 -0400
Date: Sat, 26 May 2001 19:37:39 +0200
From: Santiago Garcia Mantinan <manty@udc.es>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at inode.c:654!
Message-ID: <20010526193739.A2583@man.beta.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

That's what my server, wich is running 2.4.5, was shouting when I pluged in
my laptop at the console (ttyS0), all I could do was copy the output I was
seeing on minicom to a file, after rebooting I saw that the kernel had left
some of the logging on kern.log, so I'm attaching a file with both the stuff
on the console and the ones on the log.

The machine is an intel pentium 166 with 48 megs of mem, it has an stock
2.4.5 kernel with netfilter patches for the irc NAT, even though this
patches were working ok on 2.4.4 and don't seem to have anything to do with
this problem, I'm recompiling an stock 2.4.5 now, just to be sure.

Well, I don't know what else to say, if I'm missing something you want to
know, don't hesitate to ask.

Regards...
-- 
Manty/BestiaTester -> http://manty.net

--TB36FDmn/VVEgNH/
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="log.bz2"
Content-Transfer-Encoding: base64

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
qSNwGqE/4u5IpwoSEFCq1sA=

--TB36FDmn/VVEgNH/--
