Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUD0HEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUD0HEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 03:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbUD0HEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 03:04:37 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:24259 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S263870AbUD0HEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 03:04:35 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01E2577C@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Pre vfs level bootlog
Date: Tue, 27 Apr 2004 09:04:32 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Is there a way to isolate boot log management and storing to /boot ?
	(I'd like to record the pre-vfs stuff log but there I'm unable to
pause display nor store stuff as my /var/log is not accessible)

Regards,
Fabian
