Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbUJ0CTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbUJ0CTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbUJ0CTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:19:11 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:25486 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261559AbUJ0CTJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:19:09 -0400
Message-ID: <417F0597.6030103@rtr.ca>
Date: Tue, 26 Oct 2004 22:19:03 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Setting 32bit IO on SATA drives
References: <1098827414l.6518l.0l@werewolf.able.es>
In-Reply-To: <1098827414l.6518l.0l@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > HDIO_GET_MULTCOUNT failed: Operation not supported

Fyi, I have removed that bogus error message from my
working copy of hdparm.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
