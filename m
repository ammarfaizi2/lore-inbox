Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVCVTzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVCVTzE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVCVTyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:54:43 -0500
Received: from itbox2.apcinc.com ([12.5.87.41]:39846 "EHLO itbox2.apcinc.com")
	by vger.kernel.org with ESMTP id S261786AbVCVTul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:50:41 -0500
Subject: 2.4.22 High Memory Support for Pentium M
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFC84D44E8.1772C89A-ON86256FCC.006CFB04@mail.apcinc.com>
From: Keith LeMay <keith.lemay@ultra-ats.com>
Date: Tue, 22 Mar 2005 13:50:37 -0600
X-MIMETrack: Serialize by Router on APC1/APC(Release 6.5|September 26, 2003) at 03/22/2005
 01:50:33 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-AntiVirus: checked by AntiVir Milter (version: 1.1; AVE: 6.30.0.7; VDF: 6.30.0.41; host: itbox2.apcinc.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





I'm porting code from a Pentium III processor to a Pentium M processor
using kernel version 2.4.22.  Both processors contain 1.5Gig of RAM.  I
noticed High Memory Support must be disabled on the Pentium M platform due
to a bug that was fixed in kernel version 2.4.26.  Does anyone know how the
bug was fixed and what changes I need to port back into kernel version
2.4.22?  For various reasons, upgrading my system to kernel version 2.4.26
is not an option.  Please respond to keith.lemay@ultra-ats.com.

