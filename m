Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbTLaGLQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 01:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266135AbTLaGLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 01:11:16 -0500
Received: from cafe.hardrock.org ([142.179.182.80]:9878 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S266134AbTLaGLP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 01:11:15 -0500
Date: Tue, 30 Dec 2003 23:10:13 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-uv3 patch set released
In-Reply-To: <Pine.LNX.4.58L.0312300935040.22101@logos.cnet>
Message-ID: <Pine.LNX.4.51.0312302308040.22870@cafe.hardrock.org>
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org>
 <Pine.LNX.4.58L.0312300935040.22101@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003, Marcelo Tosatti wrote:

> 
> 
> On Mon, 29 Dec 2003, James Bourne wrote:
> 
> > linux-2.4.23-ide-busy-race-fix.patch: Daniel Lux: Fix IDE busy-wait race
> 
> I screwed up the merge of this patch, you also want to apply "Fix IDE
> busywait merge" (its the next changeset after this one).

Thanks for the info.  I did catch that on the bk list and appended it before
releasing that patch, so it is there (just confirmed).

Regards
James

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  
