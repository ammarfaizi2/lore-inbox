Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUEJX2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUEJX2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUEJXYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:24:44 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:57333 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261763AbUEJXW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:22:26 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add path-oriented proc_mkdir_path() function to /proc
Message-Id: <E1BNK6J-0001Yw-3e@peregrine.corp.google.com>
From: Edward Falk <efalk@google.com>
Date: Mon, 10 May 2004 16:22:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> ... adds the function proc_mkdir_path() ...
>
>Who uses this?

Well, almost nobody yet :)

I'm very shortly going to submit a diagnostic utility that creates
nested entries in /proc.

I originally wrote proc_mkdir_path() to make the nested entries, and
someone suggested that it be submitted as a seperate patch since it's
of general usefulness.

	-ed falk, falk@google.com
