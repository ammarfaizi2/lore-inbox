Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSJQXHt>; Thu, 17 Oct 2002 19:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262468AbSJQXHt>; Thu, 17 Oct 2002 19:07:49 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:51447 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262446AbSJQXHq>; Thu, 17 Oct 2002 19:07:46 -0400
Date: Thu, 17 Oct 2002 16:04:36 -0700
From: Chris Wright <chris@wirex.com>
To: "David S. Miller" <davem@redhat.com>
Cc: daw@mozart.cs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017160436.D26442@figure1.int.wirex.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	daw@mozart.cs.berkeley.edu, linux-kernel@vger.kernel.org
References: <20021017185352.GA32537@kroah.com> <20021017.131830.27803403.davem@redhat.com> <aonbj9$pun$1@abraham.cs.berkeley.edu> <20021017.153627.132905359.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021017.153627.132905359.davem@redhat.com>; from davem@redhat.com on Thu, Oct 17, 2002 at 03:36:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David S. Miller (davem@redhat.com) wrote:
> 
> But as far as raw seats are concerned, the majority will not use
> LSM.  They simply have no need for it on their workstation.

I agree, the average desktop user isn't even aware of the issues.  But I
think the photographer would like it if the mp3 player can't remove files
in ~/photos/ when it plays a malicious .mp3 file.  So even the desktop
user could benefit from better security infrastructure.  But your point
on security uptake is well-taken.

thanks,
-chris
