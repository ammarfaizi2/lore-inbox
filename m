Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265875AbRFYEX5>; Mon, 25 Jun 2001 00:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265876AbRFYEXr>; Mon, 25 Jun 2001 00:23:47 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:38539 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S265875AbRFYEXd>; Mon, 25 Jun 2001 00:23:33 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200106250423.FAA31292@mauve.demon.co.uk>
Subject: Where is check for superuser in TCP port bind.
To: linux-kernel@vger.kernel.org
Date: Mon, 25 Jun 2001 05:23:00 +0100 (BST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Obviously (to me) this check is in tcp_v4_get_port().
But, I can't find it, or perhaps it's better hidden than I thought.
Or maybe I'm just very confused.
Any help would be most welcome.

