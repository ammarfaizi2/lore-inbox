Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbTLKQ2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 11:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265165AbTLKQ2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 11:28:48 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:62661 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S265162AbTLKQ2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 11:28:47 -0500
Message-ID: <3FD89B45.8040905@backtobasicsmgmt.com>
Date: Thu, 11 Dec 2003 09:28:53 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][RFC] HT scheduler
References: <3FD3FD52.7020001@cyberone.com.au> <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au>
In-Reply-To: <3FD7F1B9.5080100@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> http://www.kerneltrap.org/~npiggin/w26/
> Against 2.6.0-test11
> 
> This includes the SMT description for P4. Initial results shows comparable
> performance to Ingo's shared runqueue's patch on a dual P4 Xeon.
> 

Is there any value in testing/using this on a single CPU P4-HT system, 
or is it only targeted at multi-CPU systems?

