Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268848AbRHaSqn>; Fri, 31 Aug 2001 14:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268926AbRHaSqc>; Fri, 31 Aug 2001 14:46:32 -0400
Received: from mail.intrex.net ([209.42.192.246]:20238 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S268848AbRHaSqW>;
	Fri, 31 Aug 2001 14:46:22 -0400
Date: Fri, 31 Aug 2001 14:47:14 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: How to get time of last runqueue transition.
Message-ID: <20010831144714.A12735@bessie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I want to be able to determine the time a process was last run by looking
at its process table entry.  Is this information maintained anywhere?

Thanks,

Jim
