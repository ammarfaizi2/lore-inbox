Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284766AbRLRTkF>; Tue, 18 Dec 2001 14:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284857AbRLRTjG>; Tue, 18 Dec 2001 14:39:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30865 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284837AbRLRTiN>;
	Tue, 18 Dec 2001 14:38:13 -0500
Date: Tue, 18 Dec 2001 11:37:25 -0800 (PST)
Message-Id: <20011218.113725.82100134.davem@redhat.com>
To: nicoya@apia.dhs.org
Cc: ian@ichilton.co.uk, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-rc1 wont do nfs root on Javastation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <v04003a11b84549aa834a@[24.70.162.28]>
In-Reply-To: <20011215.220646.69411478.davem@redhat.com>
	<20011218190621.A28147@buzz.ichilton.local>
	<v04003a11b84549aa834a@[24.70.162.28]>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
   Date: Tue, 18 Dec 2001 13:32:00 -0600
   
   I really think it should be a compile-time option to have it default to on,
   but I never figured out who maintains it.

How then would you get a generic, yet NFS-ROOT capable kernel?
Answer: you can't
