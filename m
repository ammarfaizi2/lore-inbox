Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbULUWHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbULUWHS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 17:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbULUWHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 17:07:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24192 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261876AbULUWGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 17:06:11 -0500
Date: Tue, 21 Dec 2004 22:06:05 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Tom Dickson <tdickson@inostor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LVM2 on 2.4.28 kernel?
Message-ID: <20041221220605.GA10199@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Tom Dickson <tdickson@inostor.com>, linux-kernel@vger.kernel.org
References: <41C852EE.90300@inostor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C852EE.90300@inostor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 08:44:30AM -0800, Tom Dickson wrote:
> I can also build device-mapper, but not using
> ./configure --with-kernel-dir
> instead, I use
> ./configure
 
That's what the INSTALL file tells you to do if you read it carefully.

Alasdair
-- 
agk@redhat.com
