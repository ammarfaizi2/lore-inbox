Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbTH0QRg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTH0QHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:07:38 -0400
Received: from www.13thfloor.at ([212.16.59.250]:57813 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S263588AbTH0QDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:03:05 -0400
Date: Wed, 27 Aug 2003 18:03:18 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: UP optimizations ..
Message-ID: <20030827160315.GD26817@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mikael!
Hi Marcelo!

stumbled repeatedly over the patches (or what remained of them)
from Mikael?, replacing task->processor and friends by inline
functions task_cpu(task), to eliminate them on UP systems ...

my questions: 
 - is there an up to date patchset?
 - is it planned to include this into 2.4.23?

TIA,
Herbert

