Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTEGNH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 09:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTEGNH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 09:07:56 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:35010 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263173AbTEGNHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 09:07:54 -0400
Date: Wed, 7 May 2003 15:20:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: top stack (l)users for 2.5.69
Message-ID: <20030507132024.GB18177@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

41 functoins for 2.5.69, 45 functions for 2.5.68, 44 for 2.5.67.
Things are improving again.

There are five more fixes remaining in -je, so it might be time for a
resend session.

P 0xc0229406 presto_get_fileid:                            sub    $0x1198,%esp
P 0xc0227bf6 presto_copy_kml_tail:                         sub    $0x1028,%esp
0xc08f1458 ide_unregister:                               sub    $0x9dc,%esp
0xc082b66b v4l_compat_translate_ioctl:                   sub    $0x8d4,%esp
0xc08b2d23 ia_ioctl:                                     sub    $0x84c,%esp
0xc0e48233 snd_emu10k1_fx8010_ioctl:                     sub    $0x830,%esp
0xc0845e86 w9966_v4l_read:                               sub    $0x828,%esp
0xc0dd895b snd_cmipci_ac3_copy:                          sub    $0x7c0,%esp
0xc0dd8f7b snd_cmipci_ac3_silence:                       sub    $0x7c0,%esp
P 0xc0a9f1a8 amd_flash_probe:                              sub    $0x72c,%esp
0xc0105650 huft_build:                                   sub    $0x59c,%esp
0xc01073d0 huft_build:                                   sub    $0x59c,%esp
0xc02e4a96 dohash:                                       sub    $0x594,%esp
0xc0108256 inflate_dynamic:                              sub    $0x554,%esp
P 0xc05d8733 ida_ioctl:                                    sub    $0x54c,%esp
0xc01064a6 inflate_dynamic:                              sub    $0x538,%esp
P 0xc0fbf8b3 device_new_if:                                sub    $0x520,%esp
0xc021ddd6 presto_ioctl:                                 sub    $0x508,%esp
0xc0e424b8 snd_emu10k1_add_controls:                     sub    $0x4dc,%esp
0xc0e6a066 snd_trident_mixer:                            sub    $0x4c0,%esp
0xc0106307 inflate_fixed:                                sub    $0x4ac,%esp
0xc01080b7 inflate_fixed:                                sub    $0x4ac,%esp
0xc0908ab1 ide_config:                                   sub    $0x4a8,%esp
0xc05bcc5c parport_config:                               sub    $0x490,%esp
0xc0c0e643 ixj_config:                                   sub    $0x484,%esp
0xc10ad9e6 sctp_hash_digest:                             sub    $0x45c,%esp
0xc104da33 gss_pipe_downcall:                            sub    $0x450,%esp
0xc03bc4c8 ciGetLeafPrefixKey:                           sub    $0x428,%esp
0xc045fae3 befs_error:                                   sub    $0x418,%esp
0xc045fb53 befs_warning:                                 sub    $0x418,%esp
0xc045fbc3 befs_debug:                                   sub    $0x418,%esp
0xc07a5c86 wv_hw_reset:                                  sub    $0x418,%esp
0xc0b4bea0 isd200_action:                                sub    $0x414,%esp
0xc1685145 root_nfs_name:                                sub    $0x414,%esp
0xc0c32172 bt3c_config:                                  sub    $0x410,%esp
0xc0c36282 btuart_config:                                sub    $0x410,%esp
0xc07642c1 hex_dump:                                     sub    $0x40c,%esp
0xc0331cf7 jffs2_rtime_compress:                         sub    $0x408,%esp
0xc0c3073f dtl1_config:                                  sub    $0x408,%esp
0xc0c34556 bluecard_config:                              sub    $0x408,%esp
0xc0331df5 jffs2_rtime_decompress:                       sub    $0x404,%esp

Jörn

-- 
A victorious army first wins and then seeks battle.
-- Sun Tzu
