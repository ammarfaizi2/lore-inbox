Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbULJNhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbULJNhX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 08:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbULJNhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 08:37:23 -0500
Received: from [193.178.151.93] ([193.178.151.93]:22651 "EHLO as.unibanka.lv")
	by vger.kernel.org with ESMTP id S261210AbULJNgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 08:36:37 -0500
From: Aivils <aivils@unibanka.lv>
Reply-To: aivils@unibanka.lv
Organization: Unibanka
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Linux input event extending tool exist?
Date: Fri, 10 Dec 2004 16:38:05 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, lineak-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412101638.05125.aivils@unibanka.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech?

	Exist right now tool which one allow to use ioctl() like
EVIOCGKEYCODE , EVIOCSKEYCODE
an so define new scan-keycodes for unknow "Pluto-Pepino-Paperino"
keyboards which keys sometimes will not generate input event
on /dev/input/eventXX

	How to debug keyboard, when showkeys keep silence?

Aivils Stoss
