Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756841AbWKTEB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841AbWKTEB3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 23:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756842AbWKTEB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 23:01:29 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:46990 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1756841AbWKTEB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 23:01:28 -0500
Date: Sun, 19 Nov 2006 19:58:13 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: kurt.hackel@oracle.com, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make ocfs2_create_new_lock() static
Message-ID: <20061120035813.GE30647@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20061120022428.GS31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120022428.GS31879@stusta.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 03:24:28AM +0100, Adrian Bunk wrote:
> This patch makes the needlessly global ocfs2_create_new_lock() static.
Ok, thanks Adrian.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
