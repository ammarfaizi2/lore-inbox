Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbTDYVhb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbTDYVhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:37:31 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:8946 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264506AbTDYVha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:37:30 -0400
Date: Fri, 25 Apr 2003 17:49:42 -0400
From: Bill Nottingham <notting@redhat.com>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: ia32 kernel on amd64 box?
Message-ID: <20030425174941.A21747@devserv.devel.redhat.com>
Mail-Followup-To: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
References: <20030425214500.GA20221@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030425214500.GA20221@ncsu.edu>; from jlnance@unity.ncsu.edu on Fri, Apr 25, 2003 at 05:45:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu (jlnance@unity.ncsu.edu) said: 
> Hello All,
>     Does anyone know if an ia32 kernel (specifically the one that comes with
> Red Hat 7.2) will work on an SMP AMD Opteron machine?

Red Hat 7.2 may or may not work, I'm not sure we've tried back that far.
Red Hat 8.0 or 9 should work fine.

Bill
