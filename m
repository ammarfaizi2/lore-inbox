Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTFDJYe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 05:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTFDJYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 05:24:34 -0400
Received: from benzin.geggus.net ([213.146.112.23]:15884 "EHLO
	benzin.geggus.net") by vger.kernel.org with ESMTP id S261222AbTFDJYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 05:24:33 -0400
Date: Wed, 4 Jun 2003 11:38:02 +0200
From: Sven Geggus <sven@gegg.us>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc2: frequent autofs hangs
Message-ID: <20030604093801.GA7094@benzin.geggus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-giggls-priority: very high :P
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

since updating from Kernel 2.4.20 to 2.4.21-rc2 my machine suffers from
frequent autofs hangs (delayed /usr/sbin/automount processes which can not
be killed).

The Userland stufff I use is the plain version from debian woody
(3.9.99-4.0.0pre10).

Any hints on how to debug this?

Sven

-- 
Why are there so many Unix-haters-handbooks and not even one
Microsoft-Windows-haters handbook?
Gurer vf ab arrq sbe n unaqobbx gb ungr Zvpebfbsg Jvaqbjf!
/me is giggls@ircnet, http://sven.gegg.us/ on the Web
