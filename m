Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264006AbUDNJ1G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 05:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbUDNJ1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 05:27:06 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:18251 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S264006AbUDNJ1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 05:27:04 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.5-mm4] sys_access race fix
From: <fabian.frederick@prov-liege.be>
Date: Wed, 14 Apr 2004 11:20:49 +0200
Reply-To: <fabian.frederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.15]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S264006AbUDNJ1E/20040414092704Z+518@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

     It seems this thread has lost its initial goal.We can't do uid changes without lock as reported in current open.c doc.Maybe there's some expert here able to tell me exactly what's wrong in this ?

http://fabian.unixtech.be/kernel/open1.diff

And most of all patch this patch as well ;)

Regards,
Fabian

___________________________________



