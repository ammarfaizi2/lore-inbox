Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263900AbTKLS0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 13:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTKLS0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 13:26:35 -0500
Received: from adsl-64-175-241-14.dsl.sntc01.pacbell.net ([64.175.241.14]:55579
	"EHLO top.worldcontrol.com") by vger.kernel.org with ESMTP
	id S263900AbTKLS0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 13:26:34 -0500
From: brian@worldcontrol.com
Date: Wed, 12 Nov 2003 10:27:11 -0800
To: linux-kernel@vger.kernel.org
Subject: Toshiba P25-S507 laptop and freezes with 2.6.0-test9
Message-ID: <20031112182711.GA5454@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Archive: yes
X-Noarchive: yes
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My Toshiba P25-S507 P4 2.8 running vanilla 2.6.0-test9 occasionally
freezes.  The freezes occur during events such as closing or opening
the lid or removing/inserting the power adapter and sometimes during
halt.

The freezes are reasonably rare. Occuring perhaps once every 3
days or so.

On the other hand, I have not been able to force one.  Purposely playing
with the power or the lid switch I have not been able to cause the
freeze.  However, everytime it happens it has been associated with one
of the actions listed above.

I believe the freezes do happen with earlier 2.6.0-test kernels,
but they seemed more rare then.  

I don't recall a freeze ever occuring with 2.4.20-gentoo-r5.

-- 
Brian Litzinger
