Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSEWMXB>; Thu, 23 May 2002 08:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316467AbSEWMXA>; Thu, 23 May 2002 08:23:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37343 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316106AbSEWMW7>;
	Thu, 23 May 2002 08:22:59 -0400
Date: Thu, 23 May 2002 05:08:42 -0700 (PDT)
Message-Id: <20020523.050842.94418311.davem@redhat.com>
To: marcel@rvs.uni-bielefeld.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops: tcp_v4_get_port
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1022154442.20761.2.camel@linux>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All 2.5.x networking bug fixes are present in current 2.4.x (this
means go check Marcelo's current pre-patch and BK trees).
