Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbTFRQAp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 12:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbTFRQAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 12:00:44 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:45889 "EHLO
	mwinf0201.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265332AbTFRQAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 12:00:32 -0400
Date: Wed, 18 Jun 2003 18:14:39 +0200
From: Jean-Luc <jean-luc.coulon@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.5.72 ALSA, many Unknown symbols
Message-ID: <20030618161439.GA1496@debian-f5ibh>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get many messages like the following and ALSA does not work (was fine 
with 2.5.70) :

snd_mixer_oss: Unknown symbol snd_info_register
snd_mixer_oss: Unknown symbol snd_info_free_entry
snd_mixer_oss: Unknown symbol snd_info_get_str
snd_mixer_oss: Unknown symbol snd_unregister_oss_device
snd_mixer_oss: Unknown symbol snd_ctl_find_id
snd_mixer_oss: Unknown symbol snd_register_oss_device
snd_mixer_oss: Unknown symbol snd_card_file_add
snd_mixer_oss: Unknown symbol snd_mixer_oss_notify_callback
snd_mixer_oss: Unknown symbol snd_iprintf
snd_mixer_oss: Unknown symbol snd_kcalloc
snd_mixer_oss: Unknown symbol snd_cards
snd_mixer_oss: Unknown symbol snd_ctl_notify
snd_mixer_oss: Unknown symbol snd_oss_info_register
snd_mixer_oss: Unknown symbol snd_kmalloc_strdup
snd_mixer_oss: Unknown symbol snd_info_create_card_entry
snd_mixer_oss: Unknown symbol snd_card_file_remove
snd_mixer_oss: Unknown symbol snd_info_unregister
snd_mixer_oss: Unknown symbol snd_info_get_line
snd_timer: Unknown symbol snd_info_register
snd_timer: Unknown symbol snd_info_create_module_entry
snd_timer: Unknown symbol snd_info_free_entry
snd_timer: Unknown symbol snd_iprintf
snd_timer: Unknown symbol snd_kcalloc
snd_timer: Unknown symbol snd_ecards_limit
snd_timer: Unknown symbol snd_oss_info_register
snd_timer: Unknown symbol snd_unregister_device
snd_timer: Unknown symbol snd_device_new
snd_timer: Unknown symbol snd_kmalloc_strdup
snd_timer: Unknown symbol snd_info_unregister
snd_timer: Unknown symbol snd_register_device
snd_pcm: Unknown symbol snd_info_register
snd_pcm: Unknown symbol snd_info_create_module_entry
snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: Unknown symbol snd_info_free_entry
snd_pcm: Unknown symbol snd_info_get_str
snd_pcm: Unknown symbol snd_ctl_register_ioctl
snd_pcm: Unknown symbol snd_card_file_add
snd_pcm: Unknown symbol snd_iprintf
snd_pcm: Unknown symbol snd_kcalloc
snd_pcm: Unknown symbol snd_major
snd_pcm: Unknown symbol snd_unregister_device
snd_pcm: Unknown symbol snd_timer_new
snd_pcm: Unknown symbol snd_device_new
snd_pcm: Unknown symbol snd_ctl_unregister_ioctl
snd_pcm: Unknown symbol snd_info_create_card_entry
snd_pcm: Unknown symbol snd_power_wait


---
regards
	Jean-Luc
