Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWHMS3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWHMS3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 14:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWHMS3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 14:29:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:17551 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750732AbWHMS3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 14:29:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:x-operating-system:user-agent:content-transfer-encoding:from;
        b=rvJ9TIA59l92sFSHUXYfbG/PzsQB3v4NyA9vw2lmDf3yq5bvUaYfor/lXGurazezACPcOgJH7HN/GAIQwPDAHuGjqWrbF2u2GHKOetFxMQdrSAVwDQIL7QOwDO15S3N2Mwh4QYMyxHgVc+NXJ09jcfadpL0q1pqS5Xxc8SwUbuo=
Date: Sun, 13 Aug 2006 21:26:44 +0200
To: linux-kernel@vger.kernel.org
Cc: vdr@linuxtv.org
Subject: 2.6.18-rc4-mm1 plays video at speed 3x with xine
Message-ID: <20060813192644.GA8207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Operating-System: Linux 2.6.18-rc3-mm2
User-Agent: Mutt/1.5.12-2006-07-14
Content-Transfer-Encoding: 8BIT
From: Gregoire Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

just tried 2.6.18-rc4-mm1 without any patch and every movies played with
xine play really too fast (mplayer is fine).

With http://marc.theaimsgroup.com/?l=linux-kernel&m=115547315918564&w=2
and the one from Frederik Deweerdt about kernel/posix-cpu-timers.c but
thats don't solve my issue...
-- 
Grégoire FAVRE  http://gregoire.favre.googlepages.com  http://www.gnupg.org
