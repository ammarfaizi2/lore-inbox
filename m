Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRCBSrU>; Fri, 2 Mar 2001 13:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129419AbRCBSrK>; Fri, 2 Mar 2001 13:47:10 -0500
Received: from ma-northadams1-47.nad.adelphia.net ([24.51.236.47]:1028 "EHLO
	sparrow.net") by vger.kernel.org with ESMTP id <S129413AbRCBSq7>;
	Fri, 2 Mar 2001 13:46:59 -0500
Date: Fri, 2 Mar 2001 13:46:54 -0500
From: Eric Buddington <eric@sparrow.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-ac[78] boot hang on k6-2 due to UP_APIC
Message-ID: <20010302134654.B52@sparrow.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of days ago, I reported that 2.4.2-ac7 was hanging on boot on
my k6-2 machine. I compiled ac-8, but turned odd UP_APIC, and it
worked (I vaguely remember some APIC-related hangs reported in the
past). If this is a new problem, I can narrow it down with a few
recompiles.

-Eric

