Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbVIUSbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbVIUSbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVIUSbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:31:35 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:62150 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1751357AbVIUSbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:31:34 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17201.42771.130115.285192@gargle.gargle.HOWL>
Date: Wed, 21 Sep 2005 22:31:47 +0400
To: Hans Reiser <reiser@namesys.com>
Cc: stephen.pollei@gmail.com, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
In-Reply-To: <433199C0.3070806@namesys.com>
References: <200509201536.j8KFa6wn011651@laptop11.inf.utfsm.cl>
	<43304A41.7080206@namesys.com>
	<feed8cdd050920150866e7925d@mail.gmail.com>
	<4330A783.9090405@namesys.com>
	<17201.14899.683012.997417@gargle.gargle.HOWL>
	<433199C0.3070806@namesys.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:

[...]

 > >
 > So what do you suggest we change it to, Nikita?

Just remove #ifdef/#endif as was suggested.

Nikita.
