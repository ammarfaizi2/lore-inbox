Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUBYJyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 04:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUBYJyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 04:54:50 -0500
Received: from mx11.sac.fedex.com ([199.81.193.118]:16399 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP id S262579AbUBYJyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 04:54:45 -0500
Date: Wed, 25 Feb 2004 17:55:11 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: how to switch from apm to acpi on 2.6?
Message-ID: <Pine.LNX.4.58.0402251751590.2869@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/25/2004
 05:54:38 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/25/2004
 05:54:40 PM,
	Serialize complete at 02/25/2004 05:54:40 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just switched from apm to acpi on 2.6.3, and found that I can't
"suspend" my notebook anymore.

I've got acpid running, and it's running correctly, but I don't have the
script to do the suspend. The sample program that came with acpid just
simply do a "shutdown".

With apmd, my machine suspends properly.

Any good scripts to suspend/resume?


Thanks,
Jeff
[ jchua@fedex.com ]
