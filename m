Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265799AbUGZPBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUGZPBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 11:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265773AbUGZPBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 11:01:51 -0400
Received: from monster.roma2.infn.it ([141.108.255.100]:13523 "EHLO
	monster.roma2.infn.it") by vger.kernel.org with ESMTP
	id S265521AbUGZOrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 10:47:46 -0400
From: "Emiliano 'AlberT' Gabrielli" <AlberT@SuperAlberT.it>
Reply-To: AlberT@SuperAlberT.it
Organization: SuperAlberT.it
To: linux-kernel@vger.kernel.org
Subject: tty1 and italian charset ...
Date: Mon, 26 Jul 2004 16:47:40 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <200407261647.40006.AlberT@SuperAlberT.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

  I'm not sure not to be OT, if so plz apologize me...

I'm fighting against a problem with "òàèìù" characters on my laptop since I 
switched to 2.6.0 ... The problem persists nowaday with 2.67 (various 
recompilations, with or without nvidia module loaded, and so on ...)

I already used "loadkeys it" and it seems to success, but tty1 still doesn't 
prints "òàèìù" characters.

The very strange thing, that let me suppose some kerenl-related issue, is that 
_every_ other tty is working fine, as it does every xterm session...

I'mwriteing now becouse just iesterday I installed a new server and I got the 
same problem here.

My laptop is running a Debian SID, the new server is running a Debian Sarge.

On both machines I'm using 2.6.7 (both debian binaries and a self compiled 
vanilla) with udev, sysfs and hotplug... my console-tools version is 0.2.3

Any suggestion ???

thank you in advance

-- 
<?php echo '       Emiliano `AlberT` Gabrielli       ',"\n",
           '  E-Mail: AlberT_AT_SuperAlberT_it  ',"\n",
           '  Web:    http://SuperAlberT.it  ',"\n",
'  IRC:    #php,#AES azzurra.com ',"\n",'ICQ: 158591185'; ?>
