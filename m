Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVCUWk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVCUWk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVCUWgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:36:43 -0500
Received: from itbox2.apcinc.com ([12.5.87.41]:28073 "EHLO itbox2.apcinc.com")
	by vger.kernel.org with ESMTP id S261947AbVCUWcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:32:35 -0500
Subject: 2.4.22 High Memory Support for Pentium M
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF0CFCB9A5.D3A8907F-ON86256FCB.007B4D6C@mail.apcinc.com>
From: Keith LeMay <keith.lemay@ultra-ats.com>
Date: Mon, 21 Mar 2005 16:32:31 -0600
X-MIMETrack: Serialize by Router on APC1/APC(Release 6.5|September 26, 2003) at 03/21/2005
 04:32:28 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-AntiVirus: checked by AntiVir Milter (version: 1.1; AVE: 6.30.0.7; VDF: 6.30.0.36; host: itbox2.apcinc.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





I'm porting code from a Pentium III processor to a Pentium M processor
using kernel version 2.4.22.  Both processors contain 1.5Gig of RAM.  I
noticed High Memory Support must be disabled on the Pentium M platform due
to a bug that was fixed in kernel version 2.4.26.  Does anyone know how the
bug was fixed and what changes I need to port back into kernel version
2.4.22?  For various reasons, upgrading my system to kernel version 2.4.26
is not an option.  Please respond to keith.lemay@ultra-ats.com.

