Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266146AbUBKV1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 16:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUBKV1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 16:27:33 -0500
Received: from smtp.terra.es ([213.4.129.129]:25895 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S266146AbUBKV1c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 16:27:32 -0500
Date: Wed, 11 Feb 2004 22:18:06 +0100
From: Diego Calleja <grundig@teleline.es>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small
 interleaved writes
Message-Id: <20040211221806.106eed62.grundig@teleline.es>
In-Reply-To: <200402120502.39300.mhf@linuxmail.org>
References: <Pine.LNX.4.44.0402111528140.23220-100000@chimarrao.boston.redhat.com>
	<200402120502.39300.mhf@linuxmail.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 12 Feb 2004 05:02:39 +0800 Michael Frank <mhf@linuxmail.org> escribió:


> 2.4 has a deadline scheduler. 2.6 default is anticipatory.

I though the 2.4 io scheduler wasn't "deadline" base, I think the first
"deadline" io scheduler was the one merged ~2.5.39

