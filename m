Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292856AbSCFBMt>; Tue, 5 Mar 2002 20:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292854AbSCFBMi>; Tue, 5 Mar 2002 20:12:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:36228 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292856AbSCFBM0>;
	Tue, 5 Mar 2002 20:12:26 -0500
Date: Tue, 05 Mar 2002 17:09:09 -0800 (PST)
Message-Id: <20020305.170909.78708394.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: sp@scali.com, adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Does kmalloc always return address below 4GB?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15492.62946.952197.632931@napali.hpl.hp.com>
In-Reply-To: <3C84E785.1D102FF9@scali.com>
	<20020305.074722.25911127.davem@redhat.com>
	<15492.62946.952197.632931@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Tue, 5 Mar 2002 08:44:18 -0800

   >>>>> On Tue, 05 Mar 2002 07:47:22 -0800 (PST), "David S. Miller" <davem@redhat.com> said:
     DaveM> IA64 was broken, it now uses HIGHMEM.
   
   No it doesn't.  Perhaps you meant to say that the Red Hat version of
   the ia64 linux kernel uses highmem?

Oh I didn't know you didn't use those changes.
Your version is still broken then.
