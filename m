Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVGYKlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVGYKlz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 06:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVGYKlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 06:41:55 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:51420 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261179AbVGYKly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 06:41:54 -0400
Date: Mon, 25 Jul 2005 12:41:49 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 10 GB in Opteron machine
Message-Id: <20050725124149.53c121de.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <20050722135532.GJ30510@unthought.net>
References: <20050722105516.6ccffb8f.Christoph.Pleger@uni-dortmund.de>
	<42E0B6E4.1030303@pobox.com>
	<20050722113138.5d81c770.Christoph.Pleger@uni-dortmund.de>
	<20050722103955.GI30510@unthought.net>
	<20050722133746.67e5f5d3.Christoph.Pleger@uni-dortmund.de>
	<20050722135532.GJ30510@unthought.net>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I now could compile the amd64-kernel successfully. I installed it on my
machine, rebooted and in the beginning everything seemed fine. But after
mounting the root (ext 3) filesystem (or before mounting, I do not know
exactly) the machine hangs. The last message I see is:

Mounting root filesystem, starting kjournald.


What can I do now?

Christoph 
