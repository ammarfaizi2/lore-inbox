Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTJBAEy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 20:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTJBAEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 20:04:54 -0400
Received: from sasami.anime.net ([208.8.184.120]:62877 "EHLO sasami.anime.net")
	by vger.kernel.org with ESMTP id S262451AbTJBAEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 20:04:53 -0400
Date: Wed, 1 Oct 2003 17:04:52 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: linux-kernel@vger.kernel.org
Subject: problem with IDE TCQ on 2.6.0-test6
Message-ID: <Pine.LNX.4.44.0310011659580.32373-100000@sasami.anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a bunch of IC35L180AVV207-1 in raid1 configuration.

If we enable IDE TCQ, we get a 'ide_dmaq_intr: stat=40, not expected' 
every few seconds. If TCQ is disabled, the messages are gone.

Replies in private email, i'm not subscribed to the list.

-Dan

