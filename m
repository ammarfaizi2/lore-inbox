Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264712AbSJORO3>; Tue, 15 Oct 2002 13:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264769AbSJORO3>; Tue, 15 Oct 2002 13:14:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1958 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264712AbSJORO0>;
	Tue, 15 Oct 2002 13:14:26 -0400
Date: Tue, 15 Oct 2002 10:13:11 -0700 (PDT)
Message-Id: <20021015.101311.119433328.davem@redhat.com>
To: rob@osinvestor.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] remove csum_partial_copy
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021014191938.T16698@osinvestor.com>
References: <20021014191938.T16698@osinvestor.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rob Radez <rob@osinvestor.com>
   Date: Mon, 14 Oct 2002 19:19:38 -0400

   The attached patch against 2.5.42 removes csum_partial_copy.  It's on top of a
   patch that I just sent to Dave removing csum_partial_copy_fromuser.  Does it
   look alright to people?  Arch maintainers?  Dave?
   
Looks perfectly fine, applied.
