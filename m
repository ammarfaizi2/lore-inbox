Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTFZOZJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 10:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTFZOZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 10:25:08 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:35511 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S261568AbTFZOZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 10:25:07 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01405360@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "'Dominik Kubla'" <dominik@kubla.de>
Cc: "'Albert Cahalan' (E-mail)" <albert@users.sf.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: fs limits
Date: Thu, 26 Jun 2003 16:24:06 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For ext2/ext3: tune2fs -l <special device>
<Why don't we have that stuff in /proc/diskstat at least for extX ?
<It could be useful for both procps or some survey tool installed.
<Problem is "where can we add that stuff".In the vfs layer ?
<AFAICS, there's no device polling (let's say each x seconds 
<to keep info up to date).

<Regards,
<Fabian
