Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVAOA7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVAOA7h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVAOA7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:59:36 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:50158 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262085AbVAOA6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:58:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Cc5dsuQaC1ySXIdJ4wdunkKHpUIwTfPIS0HEWmjvkAWthzjHTtOoPRo5Rty3Z6Bh00fk3qCDXv/9LrIXWeZ/wvZJImhtuvyQb4wY8sXnNjX9b2wYEXjivC3xaiFMk8UG0L3vKXcQ6f9n16Iu/XVmvX0/gl4/ymGxvkD7IKI/58I=
Message-ID: <58cb370e05011416584437493d@mail.gmail.com>
Date: Sat, 15 Jan 2005 01:58:44 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [UPDATE PATCH] ide/ide-cd: use ssleep() instead of schedule_timeout()
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, kj <kernel-janitors@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050107194741.GG7387@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041225004846.GA19373@nd47.coderock.org>
	 <20050107194013.GB2924@us.ibm.com> <20050107194741.GG7387@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied
