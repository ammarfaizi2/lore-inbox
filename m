Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319559AbSH3MqT>; Fri, 30 Aug 2002 08:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319560AbSH3MqT>; Fri, 30 Aug 2002 08:46:19 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:43793 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S319559AbSH3MqS>;
	Fri, 30 Aug 2002 08:46:18 -0400
Date: Fri, 30 Aug 2002 08:03:38 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@primetime>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: 2.5.32 : net/ipv4/netfilter/ipfwadm_core.c compile error 
Message-ID: <Pine.LNX.4.33.0208300801120.27846-100000@primetime>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, 
  While 'make modules', I received the following error.

Regards,
Frank

ipfwadm_core.c: In function `ip_fw_chk':
ipfwadm_core.c:450: structure has no member named `read_locked_map'
ipfwadm_core.c:450: structure has no member named `write_locked_map'
ipfwadm_core.c:450: structure has no member named `l'
ipfwadm_core.c:450: structure has no member named `read_locked_map'
ipfwadm_core.c:452: structure has no member named `read_locked_map'
ipfwadm_core.c:452: structure has no member named `write_locked_map'
ipfwadm_core.c:452: structure has no member named `l'
ipfwadm_core.c:452: structure has no member named `write_locked_map'
ipfwadm_core.c:677: structure has no member named `read_locked_map'
ipfwadm_core.c:677: structure has no member named `read_locked_map'
ipfwadm_core.c:677: structure has no member named `l'
ipfwadm_core.c:679: structure has no member named `write_locked_map'
ipfwadm_core.c:679: structure has no member named `write_locked_map'
ipfwadm_core.c:679: structure has no member named `l'
ipfwadm_core.c: In function `zero_fw_chain':
ipfwadm_core.c:689: structure has no member named `read_locked_map'
ipfwadm_core.c:689: structure has no member named `write_locked_map'
ipfwadm_core.c:689: structure has no member named `l'
ipfwadm_core.c:689: structure has no member named `write_locked_map'
ipfwadm_core.c:696: structure has no member named `write_locked_map'
ipfwadm_core.c:696: structure has no member named `write_locked_map'
ipfwadm_core.c:696: structure has no member named `l'
ipfwadm_core.c: In function `free_fw_chain':
ipfwadm_core.c:701: structure has no member named `read_locked_map'
ipfwadm_core.c:701: structure has no member named `write_locked_map'
ipfwadm_core.c:701: structure has no member named `l'
ipfwadm_core.c:701: structure has no member named `write_locked_map'
ipfwadm_core.c:710: structure has no member named `write_locked_map'
ipfwadm_core.c:710: structure has no member named `write_locked_map'
ipfwadm_core.c:710: structure has no member named `l'
ipfwadm_core.c: In function `insert_in_chain':
ipfwadm_core.c:738: structure has no member named `read_locked_map'
ipfwadm_core.c:738: structure has no member named `write_locked_map'
ipfwadm_core.c:738: structure has no member named `l'
ipfwadm_core.c:738: structure has no member named `write_locked_map'
ipfwadm_core.c:748: structure has no member named `write_locked_map'
ipfwadm_core.c:748: structure has no member named `write_locked_map'
ipfwadm_core.c:748: structure has no member named `l'
ipfwadm_core.c: In function `append_to_chain':
ipfwadm_core.c:780: structure has no member named `read_locked_map'
ipfwadm_core.c:780: structure has no member named `write_locked_map'
ipfwadm_core.c:780: structure has no member named `l'
ipfwadm_core.c:780: structure has no member named `write_locked_map'
ipfwadm_core.c:796: structure has no member named `write_locked_map'
ipfwadm_core.c:796: structure has no member named `write_locked_map'
ipfwadm_core.c:796: structure has no member named `l'
ipfwadm_core.c: In function `del_from_chain':
ipfwadm_core.c:807: structure has no member named `read_locked_map'
ipfwadm_core.c:807: structure has no member named `write_locked_map'
ipfwadm_core.c:807: structure has no member named `l'
ipfwadm_core.c:807: structure has no member named `write_locked_map'
ipfwadm_core.c:816: structure has no member named `write_locked_map'
ipfwadm_core.c:816: structure has no member named `write_locked_map'
ipfwadm_core.c:816: structure has no member named `l'
ipfwadm_core.c:868: structure has no member named `write_locked_map'
ipfwadm_core.c:868: structure has no member named `write_locked_map'
ipfwadm_core.c:868: structure has no member named `l'
ipfwadm_core.c: In function `ip_chain_procinfo':
ipfwadm_core.c:1158: structure has no member named `read_locked_map'
ipfwadm_core.c:1158: structure has no member named `write_locked_map'
ipfwadm_core.c:1158: structure has no member named `l'
ipfwadm_core.c:1158: structure has no member named `read_locked_map'
ipfwadm_core.c:1199: structure has no member named `read_locked_map'
ipfwadm_core.c:1199: structure has no member named `read_locked_map'
ipfwadm_core.c:1199: structure has no member named `l'
ipfwadm_core.c: In function `ipfw_device_event':
ipfwadm_core.c:1345: structure has no member named `read_locked_map'
ipfwadm_core.c:1345: structure has no member named `write_locked_map'
ipfwadm_core.c:1345: structure has no member named `l'
ipfwadm_core.c:1345: structure has no member named `write_locked_map'
ipfwadm_core.c:1362: structure has no member named `write_locked_map'
ipfwadm_core.c:1362: structure has no member named `write_locked_map'
ipfwadm_core.c:1362: structure has no member named `l'
make[3]: *** [ipfwadm_core.o] Error 1
make[3]: Leaving directory `/usr/src/linux/net/ipv4/netfilter'
make[2]: *** [netfilter] Error 2
make[2]: Leaving directory `/usr/src/linux/net/ipv4'
make[1]: *** [ipv4] Error 2
make[1]: Leaving directory `/usr/src/linux/net'
make: *** [net] Error 2

