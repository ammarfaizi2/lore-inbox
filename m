Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268315AbTAMToG>; Mon, 13 Jan 2003 14:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268316AbTAMToG>; Mon, 13 Jan 2003 14:44:06 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:27917 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268315AbTAMToE>; Mon, 13 Jan 2003 14:44:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15907.6411.266995.53464@iris.hendrikweg.doorn>
Date: Mon, 13 Jan 2003 20:52:43 +0100
To: linux-kernel@vger.kernel.org, Vincent Hanquez <tab@tuxfamily.org>
Subject: Re: 2.5.55 - loading bttv gives Unknown symbol videobuf_iolock
In-Reply-To: <15904.9125.477424.582645@iris.hendrikweg.doorn>
References: <15903.18683.756507.997529@iris.hendrikweg.doorn>
	<20030111121712.GA7731@darwin.gaia.net>
	<15904.9125.477424.582645@iris.hendrikweg.doorn>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: Kees Bakker <kees.bakker@xs4all.nl>
Organisation: The Tardis
X-Bill: Go away
X-Attribution: kb
From: kees.bakker@xs4all.nl (Kees Bakker)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "kb" == Kees Bakker <rnews@altium.nl> writes:

kb> You can first load video-buf. After that bttv loads without problem. So, it
kb> might be a module-init-tools problem.

With the new module-init-tools 0.9.8 the problem is solved.
-- 
