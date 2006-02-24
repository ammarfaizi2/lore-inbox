Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWBXUq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWBXUq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWBXUq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:46:28 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:35922 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751092AbWBXUq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:46:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=peIZ2EXPrLefbMi+LWjOsnAE6O47IKPrJJDrLqN3AEkQ9KyCPZI000gM+AJnBSznDdlBuh1qk0PLt0wGLL1aqFznRUYdifV7xyA2sIAwur2TEKds5tXWeujOXpbWcEZLNLWSVQqFuQSvbz22WAos6k10T+fD2OTLcpjyfeQ/gGM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 00/13] various minor patches
Date: Fri, 24 Feb 2006 21:46:41 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602242146.42100.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Trying to flush my patch queue.

The following 13 patches have all been posted to LKML previously, but seem to
have been lost.
Since I know they will eventually bit-rot if they just sit on my harddrive I have 
re-diff'ed them against 2.6.16-rc4-mm2 and are submitting them again.

They are all pretty trivial and there's no 2.6.16 material in here, so I was 
just hoping that they could make it into -mm and then eventually into 
mainline in time for 2.6.17 or later (that is unless someone screams at them).


-- 
Jesper Juhl <jesper.juhl@gmail.com>


