Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTIQAzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 20:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbTIQAzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 20:55:25 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:7862
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S262557AbTIQAzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 20:55:20 -0400
Date: Tue, 16 Sep 2003 21:01:25 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: 3com problems
Message-ID: <20030916210125.A6254@animx.eu.org>
References: <20030916235104.GA27089@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20030916235104.GA27089@schottelius.org>; from Nico Schottelius on Wed, Sep 17, 2003 at 01:51:04AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> since using test2 the 3com cards 3c90x transfer _very_ slow.
> this is reported by a friend a verified here.
> 2.4.22 is fine.
> 
> any changes in test3-test5?

I have a system with a 3c905b with the bootrom.  I last tested test3 on it
and it seemed to be quite slow.  I assumed it was because I was mounting /
over nfs.  Maybe it's not?

I have no other machines with this card running 2.6.  I know it's a
different driver but the 3c990 card I have works just fine on test3.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
