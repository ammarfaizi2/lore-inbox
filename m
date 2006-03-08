Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWCHLay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWCHLay (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWCHLay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:30:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10504 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932492AbWCHLay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:30:54 -0500
Date: Wed, 8 Mar 2006 12:30:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: 2.6.16-rc5-mm3: Why did dlm_lockres_master_requery() become global?
Message-ID: <20060308113052.GF4006@stusta.de>
References: <20060307021929.754329c9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307021929.754329c9.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 02:19:29AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc3-mm2:
>...
>  git-ocfs2.patch
>...
>  git trees
>...

Why did dlm_lockres_master_requery() become global?

It is neither used in another file nor does any of the changeset 
descriptions escribe it.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

