Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312813AbSCZXQJ>; Tue, 26 Mar 2002 18:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312826AbSCZXP7>; Tue, 26 Mar 2002 18:15:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64160 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312813AbSCZXPm>;
	Tue, 26 Mar 2002 18:15:42 -0500
Date: Tue, 26 Mar 2002 15:11:04 -0800 (PST)
Message-Id: <20020326.151104.118632068.davem@redhat.com>
To: greearb@candelatech.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: up-to-date bk repository?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CA0FEF7.90003@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


echo -n >include/asm-i386/proc_fs.h
make
