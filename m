Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbTAKNwf>; Sat, 11 Jan 2003 08:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTAKNwe>; Sat, 11 Jan 2003 08:52:34 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:60687 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267219AbTAKNwb>; Sat, 11 Jan 2003 08:52:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15904.9125.477424.582645@iris.hendrikweg.doorn>
Date: Sat, 11 Jan 2003 15:01:09 +0100
From: Kees Bakker <rnews@altium.nl>
To: linux-kernel@vger.kernel.org
To: Vincent Hanquez <tab@tuxfamily.org>
Subject: Re: 2.5.55 - loading bttv gives Unknown symbol videobuf_iolock
In-Reply-To: <20030111121712.GA7731@darwin.gaia.net>
References: <15903.18683.756507.997529@iris.hendrikweg.doorn>
	<20030111121712.GA7731@darwin.gaia.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: Kees Bakker <kees.bakker@xs4all.nl>
Organisation: The Tardis
X-Bill: Go away
X-Attribution: kb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vincent" == Vincent Hanquez <tab@tuxfamily.org> writes:

Vincent> On Fri, Jan 10, 2003 at 11:28:11PM +0100, Kees Bakker wrote:
>> With 2.5.55 I get the following error in syslog when I load bttv:
>> 
>> bttv: Unknown symbol videobuf_iolock

Vincent> same problem here.
Vincent> compiling bttv in kernel (gruick) permit to watch TV on 2.5.55.

You can first load video-buf. After that bttv loads without problem. So, it
might be a module-init-tools problem.
-- 
============================================================
Kees Bakker
The Tardis
Doorn, The Netherlands                 kees.bakker@xs4all.nl
============================================================
A free society is one where it is safe to be unpopular
