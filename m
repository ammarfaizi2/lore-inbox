Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263391AbTEGOfQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbTEGOfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:35:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57730 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263391AbTEGOfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:35:14 -0400
Date: Wed, 07 May 2003 06:40:10 -0700 (PDT)
Message-Id: <20030507.064010.42794250.davem@redhat.com>
To: wli@holomorphy.com
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       akpm@digeo.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030507144100.GD8978@holomorphy.com>
References: <3EB8E4CC.8010409@aitel.hist.no>
	<20030507.025626.10317747.davem@redhat.com>
	<20030507144100.GD8978@holomorphy.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Lee Irwin III <wli@holomorphy.com>
   Date: Wed, 7 May 2003 07:41:00 -0700
   
   In another thread, you mentioned that a certain netfilter cset had
   issues; I think it might be good to add that as a second possible
   cause.

Good point, Helge what netfilter stuff do you have in use?
Are you doing NAT?
