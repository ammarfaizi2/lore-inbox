Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310606AbSCHAUY>; Thu, 7 Mar 2002 19:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310608AbSCHAUP>; Thu, 7 Mar 2002 19:20:15 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:45837 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S310606AbSCHAUB>; Thu, 7 Mar 2002 19:20:01 -0500
Message-ID: <3C880268.2050404@megapathdsl.net>
Date: Thu, 07 Mar 2002 16:14:32 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020301
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
        Abramo Bagnara <abramo@alsa-project.org>
Subject: 2.5.6-3 -- preempt_schedule unresolved in snd-pcm.o, snd-emu10k1-synth.o
 and snd-emu10k1.o
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in 
/lib/modules/2.5.6-pre3/kernel/sound/core/snd-pcm.o
depmod: 	preempt_schedule
depmod: *** Unresolved symbols in 
/lib/modules/2.5.6-pre3/kernel/sound/pci/emu10k1/snd-emu10k1-synth.o
depmod: 	preempt_schedule
depmod: *** Unresolved symbols in 
/lib/modules/2.5.6-pre3/kernel/sound/pci/emu10k1/snd-emu10k1.o
depmod: 	preempt_schedule

CONFIG_MK7=y
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y

CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_EMU10K1=m

