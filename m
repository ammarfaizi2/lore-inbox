Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264721AbUEOUHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264721AbUEOUHx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 16:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264724AbUEOUHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 16:07:53 -0400
Received: from outmx016.isp.belgacom.be ([195.238.2.115]:17025 "EHLO
	outmx016.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264722AbUEOUHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 16:07:46 -0400
Subject: [BUG 2.6.6mm2] bk-input is broken on AMD
From: FabF <Fabian.Frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1084551172.7081.3.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 14 May 2004 18:12:52 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx016.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	2.6.6-mm2 breaks due to something wrong in bk-input patchset and it's
not atkbd relevant AFAICS.

	-Trying mm2 : I've got no keyboard."Loading keymap azerty" then normal
boo but no keyboard.
	-mm2 patch reversing bk-input : no problem.

Regards,
FabF

