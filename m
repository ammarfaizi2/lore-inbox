Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTFTIge (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 04:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTFTIgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 04:36:32 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:56481 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S262451AbTFTIYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 04:24:03 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01405331@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: linux-kernel@vger.kernel.org
Subject: No modules symbols loaded
Date: Fri, 20 Jun 2003 10:23:23 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
	I put kern.* to tty in syslog conf.Restarting it on 2.5.72, I have
"no modules symbols loaded-kernel modules not enabled" and so I'm unable to
read modules printk even with all KH options on,make modules, make
modules_install ... Did I missed something ?

Regards,
Fabian
