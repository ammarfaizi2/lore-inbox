Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbRFEKDT>; Tue, 5 Jun 2001 06:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263961AbRFEKDF>; Tue, 5 Jun 2001 06:03:05 -0400
Received: from nevald.k-net.dtu.dk ([130.225.71.226]:59102 "EHLO
	nevald.k-net.dk") by vger.kernel.org with ESMTP id <S263958AbRFEKCz>;
	Tue, 5 Jun 2001 06:02:55 -0400
Date: Tue, 5 Jun 2001 11:15:13 +0200
From: Martin Clausen <martin@ostenfeld.dk>
To: netfilter-devel@lists.samba.org, linux-kernel@vger.kernel.org
Subject: No buffer space available when using the ip_queue module
Message-ID: <20010605111513.D978@ostenfeld.dk>
Reply-To: Martin Clausen <martin@ostenfeld.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When using the ip_queue module from Netfilter I sometimes get this error:

Failed to receive netlink message: No buffer space available

Is it possible to make those kernel buffers bigger so that I don't run
into this problem?

Best regards
Martin

-- 
Failure is not an option. It comes bundled with your Microsoft product.
