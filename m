Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310257AbSCPLWS>; Sat, 16 Mar 2002 06:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310255AbSCPLWJ>; Sat, 16 Mar 2002 06:22:09 -0500
Received: from [210.19.28.11] ([210.19.28.11]:43140 "EHLO dZuRa.Vault-ID.com")
	by vger.kernel.org with ESMTP id <S310256AbSCPLVt>;
	Sat, 16 Mar 2002 06:21:49 -0500
Date: Sat, 16 Mar 2002 19:18:37 +0800
From: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
To: linux-kernel@vger.kernel.org
Subject: linux 2.5.7-pre2 compile error
Message-Id: <20020316191837.2e16aab1.Corporal_Pisang@Counter-Strike.com.my>
Organization: CS Malaysia
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
User-Agent: Half Life (Build 1760)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ip_conntrack_standalone.c: In function `kill_proto':
ip_conntrack_standalone.c:41: structure has no member named `dst'
ip_conntrack_standalone.c:43: warning: control reaches end of non-void function
make[3]: *** [ip_conntrack_standalone.o] Error 1
make[3]: Leaving directory `/usr/src/linux/net/ipv4/netfilter'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/net/ipv4/netfilter'
make[1]: *** [_subdir_ipv4/netfilter] Error 2
make[1]: Leaving directory `/usr/src/linux/net'
make: *** [_dir_net] Error 2

Regards.

-Ubaida-
