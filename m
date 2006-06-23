Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWFWJS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWFWJS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932949AbWFWJS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:18:29 -0400
Received: from jenny.ondioline.org ([66.220.1.122]:54536 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP id S932216AbWFWJS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:18:28 -0400
From: Paul Collins <paul@briny.ondioline.org>
To: johannes@sipsolutions.net
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: all-modular snd-aoa 
Mail-Followup-To: johannes@sipsolutions.net, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Date: Fri, 23 Jun 2006 19:14:45 +1000
Message-ID: <87hd2cz116.fsf@briny.internal.ondioline.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this when building from Linus's current git tree:

    LD      sound/built-in.o
  ld: sound/aoa/built-in.o: No such file: No such file or directory
  make[1]: *** [sound/built-in.o] Error 1
  make: *** [sound] Error 2

Doing "touch sound/aoa/built-in.o" lets the build continue and
complete successfully.

-- 
Paul Collins
Melbourne, Australia

Dag vijandelijk luchtschip de huismeester is dood
