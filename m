Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268041AbUHKM1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268041AbUHKM1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 08:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUHKM1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 08:27:18 -0400
Received: from mx2.perftech.si ([195.246.0.30]:24585 "EHLO butn.net")
	by vger.kernel.org with ESMTP id S268041AbUHKM1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 08:27:12 -0400
Date: Wed, 11 Aug 2004 14:27:07 +0200
From: "xerces8" <xerces8@butn.net>
To: linux-kernel@vger.kernel.org, p.lavarre@ieee.org, dburg@nero.com
Subject: Re: Can not read UDF CD
Message-ID: <WorldClient-F200408111427.AA27073829@butn.net>
X-Mailer: WorldClient 6.8.5
X-Authenticated-Sender: xerces8@butn.net
X-Spam-Processed: butn.net, Wed, 11 Aug 2004 14:27:08 +0200
	(not processed: message from valid local sender)
X-MDRemoteIP: 127.0.0.1
X-Return-Path: xerces8@butn.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I (D.Balazic, from another email account) created another CD and it has
the same problem.

Nero version : 5.5.10.56
OS : Windows 2003 Enterprise Edition

Nero settings :

 - FS : UDF
 - UDF partition type : Physical
   FS version : UDF 1.02

I burned a small text file in the first session and then another text file
in the second session ( did not finalize the CD ).

It can not be mounted in linux. Using the mount option session=0 mounts
the first session, but I can only list the files (well, one file), not
access them. This time I used a slightly older kernel, the one from Fedora
Core 2 ( 2.6.7-something IIRC ).

So it seems the problem is reproducable both in Nero 5.5.x and 6.x

Regards,
David

