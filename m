Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277836AbRJRRnW>; Thu, 18 Oct 2001 13:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277847AbRJRRnM>; Thu, 18 Oct 2001 13:43:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8836 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277836AbRJRRm6>;
	Thu, 18 Oct 2001 13:42:58 -0400
Date: Thu, 18 Oct 2001 10:43:23 -0700 (PDT)
Message-Id: <20011018.104323.26964897.davem@redhat.com>
To: frankeh@watson.ibm.com
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Patch and Performance of larger pipes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011018113436.A9459@watson.ibm.com>
In-Reply-To: <20011018113436.A9459@watson.ibm.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Have you looked at all at the zerocopy pipe patches?
How do they affect the results, and by itself does it
do better than any of the schemes you propose?

Franks a lot,
David S. Miller
davem@redhat.com
