Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267952AbTGNIkM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 04:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268390AbTGNIkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 04:40:11 -0400
Received: from pooh.lsc.hu ([195.56.172.131]:62422 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S267952AbTGNIkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 04:40:09 -0400
Date: Mon, 14 Jul 2003 10:48:32 +0200
From: GCS <gcs@lsc.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 user report
Message-ID: <20030714084832.GC4054@gcs.org.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

 Works well on two machines:
1. Intel PIII 550Mhz, 192Mb RAM, two ATA100 hdd, LVM1 used with the new DM
(LVM2), DVD, CD writer;
2. Gericom notebook, Intel Tualatin 1.2Ghz, 512Mb RAM, DVD, CD writer.
(Expect the Synaptics touchpad in the notebook, dead without the
psmouse_noext=1 workaround).

Cheers,
GCS
-- 
BorsodChem Joint-Stock Company				Linux Support Center
Software engineer					Developer
+36-48-511211/12-99					+36-20-4441745
