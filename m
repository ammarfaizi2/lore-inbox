Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWIJV1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWIJV1f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 17:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWIJV1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 17:27:35 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:45968 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1751063AbWIJV1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 17:27:34 -0400
Date: Mon, 11 Sep 2006 01:27:32 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: rcu_do_batch: rcu_data->qlen is not irq safe
Message-ID: <20060910212732.GA437@oleg>
References: <20060910150820.GA7433@oleg> <20060910205827.GD4690@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910205827.GD4690@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



