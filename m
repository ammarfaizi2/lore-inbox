Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbWJLQ20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbWJLQ20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWJLQ20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:28:26 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:12846 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932670AbWJLQ2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:28:25 -0400
Date: Thu, 12 Oct 2006 09:28:20 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Kurt Hackel <kurt.hackel@oracle.com>
Subject: Re: [PATCH] ocfs2: delete redundant memcmp()
Message-ID: <20061012162820.GT6485@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20061012052933.GB29465@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012052933.GB29465@localhost>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 02:29:33PM +0900, Akinobu Mita wrote:
> This patch deletes redundant memcmp() while looking up in rb tree.
Looks good, thanks.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
