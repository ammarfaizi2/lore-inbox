Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbUKHFxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUKHFxb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 00:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbUKHFxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 00:53:30 -0500
Received: from smtp.persistent.co.in ([202.54.11.65]:40378 "EHLO
	smtp.pspl.co.in") by vger.kernel.org with ESMTP id S261735AbUKHFxZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 00:53:25 -0500
Message-ID: <418F09F5.10406@persistent.co.in>
Date: Mon, 08 Nov 2004 11:23:57 +0530
From: Sumesh <sumesh_kumar@persistent.co.in>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ensoniq ES1371 not working.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAQ=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

     I have a Ensoniq ES1371 sound card on a RH 9 (2.4.20-8). When i try 
to load my module i get the following errors.

shell -  insmod /lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o
/lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o: unresolved symbol 
unregister_sound_mixer_R7afc9d8a
/lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o: unresolved symbol 
ac97_probe_codec_R84601c2b
/lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o: unresolved symbol 
gameport_unregister_port_R70daab68
/lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o: unresolved symbol 
register_sound_dsp_R6f010327
/lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o: unresolved symbol 
register_sound_midi_R863bed3e
/lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o: unresolved symbol 
unregister_sound_dsp_Rcd083b10
/lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o: unresolved symbol 
register_sound_mixer_Rbf2baa60
/lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o: unresolved symbol 
gameport_register_port_R98692e58
/lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o: unresolved symbol 
unregister_sound_midi_Rfdab6de3


Thanks in advance for the help.

-- 
Regards,
Sumesh

