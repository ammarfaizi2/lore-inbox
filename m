Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTEKM5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbTEKM5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:57:24 -0400
Received: from ulima.unil.ch ([130.223.144.143]:13233 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id S261338AbTEKM5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:57:03 -0400
Date: Sun, 11 May 2003 15:09:45 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: lilo and 2.5.69?
Message-ID: <20030511130945.GA10607@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Normally I have in my lili.conf:

append = "root=/dev/scsi/host0/bus0/target15/lun0/part2 video=matrox:1600x1200-16@75"

But I got:

Fatal: open /dev/ide/host0/bus0/target0/lun0/par: No such file or
directory
Exit 1

Same if I put:
root=/dev/scsi/host0/bus0/target15/lun0/part2

Or root=/dev/sdb2

Is there something special to do with this new kernel?

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
