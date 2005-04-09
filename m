Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVDIR47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVDIR47 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 13:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVDIR47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 13:56:59 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:60181 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261360AbVDIR45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 13:56:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=uY1o0Q66ZUiYlQKZPBSuAEVqFXcqYJKs5ilHgJjXRUXBV4dtwQNCiZXPB/OmUaIKcOx/Qhcnnuayy6v2eXsV62zI6D4z00iIXRd0pT8e65Sv/gVSIVNsW9uOiout/aBd2yodbQ1hxVPJm/hVR+0WZ0P5rb7DcsUpuoaUYSTWWKk=
Message-ID: <84fecab05040910564a36366e@mail.gmail.com>
Date: Sat, 9 Apr 2005 19:56:57 +0200
From: Valery Khamenya <khamenya@gmail.com>
Reply-To: Valery Khamenya <khamenya@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: reboot problem in 2.6.x kernels, where 2.4.x kernels work well
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

as I reported before (see here: 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0503.3/0975.html or
here: http://lkml.org/lkml/2005/3/28/38 ) -- there is a reboot problem
under 2.6.x
kernels with VIA EPIA MS boards.

Now I have found that kernels 2.4.x seem to work well under different 
reboot combinations (apm=on|off acpi=on|off reboot=b|w) i tried so far.

So, it looks like problem is rather specific to kernels 2.6.x only.
No idea why though.

P.S. Thank you for Cc answers to me.
-- 
Valery A.Khamenya
