Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270412AbTGPItz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270516AbTGPItz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:49:55 -0400
Received: from [213.39.233.138] ([213.39.233.138]:31134 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S270412AbTGPItx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:49:53 -0400
Date: Wed, 16 Jul 2003 11:04:44 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: Re: top stack users for 2.6.0test1
Message-ID: <20030716090444.GC4227@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

44 functions for 2.5.67
45 functions for 2.5.68
41 functions for 2.5.69
36 functions for 2.5.70
32 functions for 2.5.71
29 functions for 2.5.73
32 functions for 2.5.74
32 functions for 2.6.0test1

Nothing changed since 2.5.74, completely boring.

0xc0232fe6 presto_get_fileid:                            sub    $0x119c,%esp
0xc02317a6 presto_copy_kml_tail:                         sub    $0x1028,%esp
0xc093b7a8 ide_unregister:                               sub    $0xa5c,%esp
0xc0e941c3 snd_emu10k1_fx8010_ioctl:                     sub    $0x830,%esp
0xc0886486 w9966_v4l_read:                               sub    $0x828,%esp
0xc0e24d5b snd_cmipci_ac3_silence:                       sub    $0x7c0,%esp
0xc0e247a6 snd_cmipci_ac3_copy:                          sub    $0x7b8,%esp
0xc0105650 huft_build:                                   sub    $0x59c,%esp
0xc01073d0 huft_build:                                   sub    $0x59c,%esp
0xc02e6086 dohash:                                       sub    $0x594,%esp
0xc0108256 inflate_dynamic:                              sub    $0x554,%esp
0xc01064a6 inflate_dynamic:                              sub    $0x538,%esp
0xc02277c6 presto_ioctl:                                 sub    $0x504,%esp
0xc0e8e46a snd_emu10k1_add_controls:                     sub    $0x4dc,%esp
0xc0eb6286 snd_trident_mixer:                            sub    $0x4c0,%esp
0xc0106307 inflate_fixed:                                sub    $0x4ac,%esp
0xc01080b7 inflate_fixed:                                sub    $0x4ac,%esp
0xc0952701 ide_config:                                   sub    $0x4a8,%esp
0xc05ec34c parport_config:                               sub    $0x490,%esp
0xc0c76143 ixj_config:                                   sub    $0x484,%esp
0xc0baedb0 isd200_action:                                sub    $0x454,%esp
0xc10b790e gss_pipe_downcall:                            sub    $0x44c,%esp
0xc03c36c8 ciGetLeafPrefixKey:                           sub    $0x428,%esp
0xc046aad3 befs_error:                                   sub    $0x418,%esp
0xc046ab43 befs_warning:                                 sub    $0x418,%esp
0xc046abb3 befs_debug:                                   sub    $0x418,%esp
0xc07e1d26 wv_hw_reset:                                  sub    $0x418,%esp
0xc1706935 root_nfs_name:                                sub    $0x414,%esp
0xc0c99a02 bt3c_config:                                  sub    $0x410,%esp
0xc0c9db22 btuart_config:                                sub    $0x410,%esp
0xc0c97fdf dtl1_config:                                  sub    $0x408,%esp
0xc0c9bdf6 bluecard_config:                              sub    $0x408,%esp


Jörn

-- 
Fantasy is more important than knowlegde. Knowlegde is limited,
while fantasy embraces the whole world.
-- Albert Einstein
