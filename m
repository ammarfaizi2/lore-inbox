Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314747AbSEUVoL>; Tue, 21 May 2002 17:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314753AbSEUVoK>; Tue, 21 May 2002 17:44:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3278 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314747AbSEUVoK>;
	Tue, 21 May 2002 17:44:10 -0400
Date: Tue, 21 May 2002 14:30:11 -0700 (PDT)
Message-Id: <20020521.143011.30682853.davem@redhat.com>
To: Wayne.Brown@altec.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.17
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <86256BC0.0067E23B.00@smtpnotes.altec.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Wayne.Brown@altec.com
   Date: Tue, 21 May 2002 13:52:08 -0500

   Under 2.5.17 there is a problem with gtop 1.0.9.

The /proc/meminfo output changed, and this makes a lot of programs
reading that file explode.
