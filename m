Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWDDEcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWDDEcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 00:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWDDEcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 00:32:00 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:64111 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751467AbWDDEb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 00:31:59 -0400
Date: Mon, 3 Apr 2006 21:28:34 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: kurt.hackel@oracle.com, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/ocfs2/dlm/dlmrecovery.c: make dlm_lockres_master_requery() static
Message-ID: <20060404042834.GZ25194@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060331145355.GF3893@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331145355.GF3893@stusta.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 04:53:55PM +0200, Adrian Bunk wrote:
> dlm_lockres_master_requery() became global without any external usage.
Looks good, thanks.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

