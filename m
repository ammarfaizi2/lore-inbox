Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284854AbRLRUCE>; Tue, 18 Dec 2001 15:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284860AbRLRUB6>; Tue, 18 Dec 2001 15:01:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51601 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284967AbRLRUBF>;
	Tue, 18 Dec 2001 15:01:05 -0500
Date: Tue, 18 Dec 2001 12:00:34 -0800 (PST)
Message-Id: <20011218.120034.132928760.davem@redhat.com>
To: nicoya@apia.dhs.org
Cc: ian@ichilton.co.uk, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-rc1 wont do nfs root on Javastation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <v04003a12b8454bdc0779@[24.70.162.28]>
In-Reply-To: <v04003a11b84549aa834a@[24.70.162.28]>
	<20011218.113725.82100134.davem@redhat.com>
	<v04003a12b8454bdc0779@[24.70.162.28]>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
   Date: Tue, 18 Dec 2001 13:46:03 -0600
   
   Alternatley, having a configuration option to set a commandline, like some
   other arches have, would also work.

I like this idea better, it solves more problems than just the nfs
root case.
