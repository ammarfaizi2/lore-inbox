Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264598AbUA0Swj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUA0Swi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:52:38 -0500
Received: from ssa8.serverconfig.com ([209.51.129.179]:18145 "EHLO
	ssa8.serverconfig.com") by vger.kernel.org with ESMTP
	id S264598AbUA0Swe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:52:34 -0500
From: "Joseph D. Wagner" <theman@josephdwagner.info>
To: Andi Kleen <ak@suse.de>, Rui Saraiva <rmps@joel.ist.utl.pt>
Subject: Re: RFC: Trailing blanks in source files
Date: Tue, 27 Jan 2004 12:51:34 -0600
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt.suse.lists.linux.kernel> <p73bropfdgl.fsf@nielsen.suse.de>
In-Reply-To: <p73bropfdgl.fsf@nielsen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401271251.34926.theman@josephdwagner.info>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ssa8.serverconfig.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - josephdwagner.info
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems that many files [1] in the Linux source have lines with
> trailing blank (space and tab) characters and some even have formfeed
> characters. Obviously these blank characters aren't necessary.

Actually, they are necessary.

http://www.gnu.org/prep/standards_23.html
http://www.gnu.org/prep/standards_24.html

