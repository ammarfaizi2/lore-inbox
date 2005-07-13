Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbVGMKw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbVGMKw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbVGMKuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:50:16 -0400
Received: from mail.charite.de ([160.45.207.131]:59082 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S262773AbVGMKsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:48:52 -0400
Date: Wed, 13 Jul 2005 12:48:49 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Current kexec status?
Message-ID: <20050713104848.GJ4561@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to experiment with kexec and my 2.6.13-rc3 kernel. I'm able to
--load the kernel, but on --exec in /etc/init.d/reboot (I replaced the
reboot command in there), the machine freezes.

I'm using kexec-tools-1.101, are there any more patches needed?

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
