Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWJQQM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWJQQM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWJQQM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:12:57 -0400
Received: from rune.pobox.com ([208.210.124.79]:11668 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1751273AbWJQQM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:12:56 -0400
Date: Tue, 17 Oct 2006 11:12:51 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Yao Fei Zhu <walkinair@cn.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [Regression] cpu hotplug failed on kernel 2.6.19-rc2
Message-ID: <20061017161251.GB18689@localdomain>
References: <4534D7C6.2080402@cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4534D7C6.2080402@cn.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yao Fei Zhu wrote:

> Running cpu hotplug regression tsstcase lhcs_regression on kernel
> 2.6.19-rc2/IBM System p5 will fall into xmon.

Your subject implies this is a regression; what is the most recent
kernel that worked?

