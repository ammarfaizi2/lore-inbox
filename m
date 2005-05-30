Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVE3DpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVE3DpF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 23:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVE3DpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 23:45:05 -0400
Received: from web32604.mail.mud.yahoo.com ([68.142.207.231]:55699 "HELO
	web32604.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261510AbVE3DpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 23:45:01 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=fKkBekWVATAzdDMp/5Nm5a4av1Oz8HT+RC/RbFU6x1UD5qMuOQtX22YBEELcCq3Y4j4f2du6nuzJwc1IWDRM31b+0Sv2mV+J2KX3ZgR0vPfC8JO3BHl/X6q6KBjg3zDfurWQjtdMxoQPzqbxGGiMuSHt1Ht2crCFb/jU6vR95e8=  ;
Message-ID: <20050530034500.82628.qmail@web32604.mail.mud.yahoo.com>
Date: Sun, 29 May 2005 20:45:00 -0700 (PDT)
From: frank nero <m4rcos2003@yahoo.com>
Subject: oops in kernel 2.6.11.10 (list of modules loaded was incomplete)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the modules loaded list was incomplete, the
corrected list is:

Modules Loaded:
 
nls_cp437 vfat fat ipt_TCPMSS ipt_limit ip_nat_irc
ip_nat_ftp iptable_mangle ipt_LOG ipt_MASQUERADE
iptable_nat ipt_TOS ipt_REJECT ip_conntrack_irc
ip_conntrack_ftp ipt_state ip_conntrack iptable_filter
ip_tables ohci_hcd ehci_hcd pcspkr rtc snd_via82xx
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd_page_alloc gameport snd_mpu401_uart
snd_rawmidi snd_seq_device snd soundcore via686a
i2c_sensor i2c_core uhci_hcd usbcore tsdev evdev
parport_pc lp parport ne 8390 8139too mii

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
