Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265253AbUFXOEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUFXOEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 10:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUFXOEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:04:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38867 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265253AbUFXOEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:04:20 -0400
Date: Thu, 24 Jun 2004 10:04:10 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Valdis.Kletnieks@vt.edu
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Joshua Brindle <jbrindle@snu.edu>,
       "Serge E. Hallyn" <hallyn@CS.WM.EDU>
Subject: Re: [PATCH][SELINUX] Extend and revise calls to secondary module 
In-Reply-To: <200406240607.i5O67uQ1020287@turing-police.cc.vt.edu>
Message-ID: <Xine.LNX.4.44.0406241003390.4970-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004 Valdis.Kletnieks@vt.edu wrote:

> For those who tuned in late, this patch is a superset of a patch I had to make to
> get some LSM work of mine to play nice with SELinux (my original request to the
> SELinux crew included 2 other hooks which I since retracted, having found other
> solutions).
> 
> It also addresses at least some of the things that Serge Hallyn was looking at
> doing with some other LSM work, and also cleans up some issues for yet a third
> thing that Serge and I were semi-collaborating on (no Serge, I hadn't forgotten
> about that, I was sort of dragging my feet waiting for this patch to show up
> and make my life a lot simpler.. ;)

Is any of this work heading into the mainline kernel?


- James
-- 
James Morris
<jmorris@redhat.com>


