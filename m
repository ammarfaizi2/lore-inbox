Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbTKULd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 06:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbTKULd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 06:33:57 -0500
Received: from mail.poliba.it ([193.204.49.50]:64437 "EHLO mail.poliba.it")
	by vger.kernel.org with ESMTP id S264356AbTKULd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 06:33:56 -0500
Date: Fri, 21 Nov 2003 12:33:42 +0000
From: Luca De Cicco <ldecicco@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: TCP retransmissions per connection
Message-Id: <20031121123342.6cd41e22.ldecicco@gmx.net>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...First of all, please excuse me if this is not the right place to post this question. If not
please address me to the correct mailing list and i'll apologize. 

I want to keep track of TCP retransmissions for all TCP connections. I need this to compare 
retransmissions with a new congestion control algorithm i developed for my thesis. 
Is there a place or a way to get values?

Thnx in advance,
Luca
