Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTFJJsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 05:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTFJJsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 05:48:52 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:36054 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261294AbTFJJsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 05:48:51 -0400
Date: Tue, 10 Jun 2003 15:35:27 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Misc 2.5 Fixes: Summary
Message-ID: <20030610100527.GA2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches fix various problems mostly related to
copy/user problems and leaks. I worked based on Alan's list and
either forward ported from 2.4 whatever was available or fixed
by code inspection. They compile, but haven't really been tested.
They are diffed against 2.5.70.

Thanks
Dipankar
