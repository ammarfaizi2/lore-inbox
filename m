Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbULOVq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbULOVq2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 16:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbULOVq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 16:46:28 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:45537 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262505AbULOVqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 16:46:25 -0500
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: "mike mike" <listsub@hotmail.com>
Subject: Re: 2g/2g split
Date: Wed, 15 Dec 2004 22:46:06 +0100
User-Agent: KMail/1.7.1
Cc: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org
References: <BAY22-F10C3E172FBB1C6E1585178A9AD0@phx.gbl>
In-Reply-To: <BAY22-F10C3E172FBB1C6E1585178A9AD0@phx.gbl>
Organization: Linux-Systeme GmbH
X-Operating-System: Linux 2.4.20-wolk4.16 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200412152246.06947@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 December 2004 22:36, mike mike wrote:

> Thanks for the reply.
> I did a "make xconfig", after extracting the source.  I don't see any place
> to enable this setting. Is that what I'm supposed to do, or something else

Right. You can't see such things because it isn't in the mainline kernel ;)

You have to patch that feature in. Try this I've posted some days ago:

http://mail.nl.linux.org/kernelnewbies/2004-12/msg00073.html


ciao, Marc
