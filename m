Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262139AbSJ2R1Z>; Tue, 29 Oct 2002 12:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262148AbSJ2R1Z>; Tue, 29 Oct 2002 12:27:25 -0500
Received: from mako.theneteffect.com ([63.97.58.10]:56590 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id <S262139AbSJ2R1Y>; Tue, 29 Oct 2002 12:27:24 -0500
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200210291733.LAA26456@mako.theneteffect.com>
Subject: 2.4.20-rc1 and i810_audio
To: linux-kernel@vger.kernel.org
Date: Tue, 29 Oct 2002 11:33:47 -0600 (CST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice that rc1 doesn't have Juergen Sawinski's updates (0.23/0.24)
to i810_audio that allow ICH4 (i845) based chipsets to work.  They've
been in AC for a while (since pre5 I think) - just wondering if that is a
merge problem or if there is something else the matter (they seem to
work great on the i845E I've got.)

	M
