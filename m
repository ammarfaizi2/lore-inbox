Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTIQQem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 12:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTIQQem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 12:34:42 -0400
Received: from kira.skynet.be ([195.238.2.125]:38528 "EHLO kira.skynet.be")
	by vger.kernel.org with ESMTP id S262110AbTIQQel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 12:34:41 -0400
Date: Fri, 2 Nov 2001 10:53:39 +0000 (europe)
From: jarausch@belgacom.net
Reply-To: jarausch@belgacom.net
Subject: 2.4.14-pre7 Unresolved symbols
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Message-Id: <20030917161954.69859BC016@numa.skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

trying to build 2.4.14-pre7 breaks with the error message
depmod: *** Unresolved symbols in /lib/modules/2.4.14-pre7/kernel/fs/romfs/romfs.o
depmod:         unlock_page

during make modules_install.

2.4.14-pre6 is running fine here.

Thank for hint,
Helmut Jarausch

Inst. of Technology
RWTH Aachen
Germany


