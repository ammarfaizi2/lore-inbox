Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWEPFar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWEPFar (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 01:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWEPFar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 01:30:47 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:62893 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751309AbWEPFaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 01:30:46 -0400
Date: Mon, 15 May 2006 21:31:07 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: HELP! vfs_readv() issue
Message-ID: <20060516043107.GA5321@taniwha.stupidest.org>
References: <4ae3c140605151657m152c0e7bl7f52e2a2def0aeca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140605151657m152c0e7bl7f52e2a2def0aeca@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 07:57:21PM -0400, Xin Zhao wrote:

> I am writing a file system, but vfs_read() sometimes return 0. What
> could cause this problem?

EOF?
