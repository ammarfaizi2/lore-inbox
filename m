Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbTIDLfT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 07:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264926AbTIDLfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 07:35:19 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:6634 "EHLO
	mwinf0603.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264923AbTIDLfP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 07:35:15 -0400
From: Laurent =?iso-8859-1?q?Hug=E9?= <laurent.huge@wanadoo.fr>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Call of tty->driver.write provides segmentation fault
Date: Thu, 4 Sep 2003 13:35:14 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200309041107.12393.laurent.huge@wanadoo.fr> <20030904105257.B7387@flint.arm.linux.org.uk>
In-Reply-To: <20030904105257.B7387@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309041335.14730.laurent.huge@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Jeudi 4 Septembre 2003 11:52, Russell King a écrit :
> You need to look at the kernel messages - normally you'll find an
> "oops" in there when this happens.
There's no Oops ; I've only got a segmentation fault, but the kernel doesn't 
crash.
-- 
Laurent Hugé.

