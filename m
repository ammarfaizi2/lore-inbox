Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUE0VMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUE0VMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 17:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbUE0VMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 17:12:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265274AbUE0VMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 17:12:46 -0400
Date: Thu, 27 May 2004 17:12:33 -0400
From: Alan Cox <alan@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Vincent Lefevre <vincent@vinc17.org>
Subject: Re: [2.4.26] overcommit_memory documentation clarification
Message-ID: <20040527211233.GA357@devserv.devel.redhat.com>
References: <20040509001045.GA23263@ay.vinc17.org> <20040509214941.GG7161@ay.vinc17.org> <20040527122042.GC13095@logos.cnet> <200405271430.11125@WOLK> <20040527130925.GA13520@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527130925.GA13520@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 10:09:25AM -0300, Marcelo Tosatti wrote:
> The strict overcommit fixes need to be extraced and tested.

Bero's tree has them. If you merge it it is probably good to make
the small changes so it works like 2.6

