Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288967AbSBKNEo>; Mon, 11 Feb 2002 08:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288971AbSBKNEf>; Mon, 11 Feb 2002 08:04:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5248 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288967AbSBKNEO>;
	Mon, 11 Feb 2002 08:04:14 -0500
Date: Mon, 11 Feb 2002 05:02:33 -0800 (PST)
Message-Id: <20020211.050233.41629715.davem@redhat.com>
To: green@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: unix sockets problems in 2.5.4-pre6?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020211115919.A963@namesys.com>
In-Reply-To: <20020211111904.A955@namesys.com>
	<20020211.004953.74751936.davem@redhat.com>
	<20020211115919.A963@namesys.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oleg Drokin <green@namesys.com>
   Date: Mon, 11 Feb 2002 11:59:19 +0300

   Ok. I do not know how to find who is holding teh lock, so here is
   full list of processes: 

Looks like memory corruption.
