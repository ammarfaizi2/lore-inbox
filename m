Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbUJXVz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbUJXVz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 17:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbUJXVz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 17:55:57 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:59786 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261600AbUJXVzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 17:55:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=o6qPuZPyTIh22bAfQ7Bt5mmBqPRB1+N1LgHqVbLdHFtCRafNNCSuGJ2Dj7FN2PvOGzQxnAxHR8p2XesxmkO4+jZ4YUHBFvZ8Ai97WhqVOQszK2OKSNHLEUaWGElcXneSiRkdS6u00CNXP+I/Ax2liCJZgnW0xmSH6NVrbrZKApg=
Message-ID: <35fb2e59041024144970522110@mail.gmail.com>
Date: Sun, 24 Oct 2004 22:49:13 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH] Restricted hard realtime
Cc: paulmck@us.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, karim@opersys.com
In-Reply-To: <20041024212359.GA7328@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041023194721.GB1268@us.ibm.com>
	 <1098562921.3306.182.camel@thomas> <20041023212421.GF1267@us.ibm.com>
	 <35fb2e5904102315066c6892aa@mail.gmail.com>
	 <20041024153204.GA1262@us.ibm.com> <417C19D5.7050802@jonmasters.org>
	 <20041024212359.GA7328@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2004 23:23:59 +0200, Ingo Molnar <mingo@elte.hu> wrote:

> also note that (as i mentioned it in an earlier reply to Paul) the
> 'CPU[s] isolated for hard-RT use' scheduler feature has already been
> implemented by Dimitri Sivanich and was accepted and integrated into the
> 2.6.9 kernel a couple of weeks ago.

I saw the posts. I should go check that out myself for interest's sake
- thanks for the info. Scheduling domains is something I haven't
looked in to in much detail yet as they're not something which usually
concern me greatly.

Jon.
