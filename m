Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312370AbSDASPJ>; Mon, 1 Apr 2002 13:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312373AbSDASOs>; Mon, 1 Apr 2002 13:14:48 -0500
Received: from dns.vamo.orbitel.bg ([195.24.63.30]:27396 "EHLO
	idi.vamo.orbitel.bg") by vger.kernel.org with ESMTP
	id <S312370AbSDASOn>; Mon, 1 Apr 2002 13:14:43 -0500
Message-ID: <3CA8A379.EA510E15@vamo.orbitel.bg>
Date: Mon, 01 Apr 2002 21:14:17 +0300
From: Ivan Ivanov <ivandi@vamo.orbitel.bg>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20acl i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext2 quota bug in 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on ext2 filesystem chown/chgroup doesn't change quota
ext3 is OK

----
Ivan



