Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWDSEnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWDSEnC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 00:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWDSEnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 00:43:01 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:2170 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750706AbWDSEnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 00:43:00 -0400
Date: Tue, 18 Apr 2006 21:42:43 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kurt Hackel <kurt.hackel@oracle.com>, ocfs2-devel@oss.oracle.com,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH 1/5] Remove redundant NULL checks before [kv]free - in fs/
Message-ID: <20060419044243.GJ25194@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <200604170329.11589.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604170329.11589.jesper.juhl@gmail.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 03:29:11AM +0200, Jesper Juhl wrote:
> Remove redundant NULL checks before kfree
> for fs/
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Acked-by: Mark Fasheh <mark.fasheh@oracle.com>
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

