Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTGFQUc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbTGFQUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:20:31 -0400
Received: from mail.ithnet.com ([217.64.64.8]:13 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S262497AbTGFQU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:20:28 -0400
Date: Sun, 6 Jul 2003 18:34:53 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.22-pre3 and reiserfs boot problem
Message-Id: <20030706183453.74fbfaf2.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just tried 2.4.22-pre3 and found out I cannot boot my test box any more. It
halts at:

reiserfs: found format "3.6" with standard journal

on a partition located on aic7xxx based hd. 

Booting the box with pre2 works perfectly well.
Anything I should try? What information is needed?

Regards,
Stephan

