Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTDENUn (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 08:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTDENUn (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 08:20:43 -0500
Received: from imladris.surriel.com ([66.92.77.98]:37066 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S262196AbTDENUl (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 08:20:41 -0500
Date: Sat, 5 Apr 2003 08:31:58 -0500 (EST)
From: Rik van Riel <riel@imladris.surriel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       "" <mingo@elte.hu>, "" <hugh@veritas.com>, "" <dmccr@us.ibm.com>,
       "" <linux-kernel@vger.kernel.org>, "" <linux-mm@kvack.org>
Subject: Re: objrmap and vmtruncate
In-Reply-To: <8950000.1049518163@[10.10.2.4]>
Message-ID: <Pine.LNX.4.50L.0304050831400.2553-100000@imladris.surriel.com>
References: <20030405024414.GP16293@dualathlon.random>
 <Pine.LNX.4.44.0304042255390.32336-100000@chimarrao.boston.redhat.com>
 <20030405041018.GG993@holomorphy.com> <8950000.1049518163@[10.10.2.4]>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Apr 2003, Martin J. Bligh wrote:

> I don't think we have an app that has 1000 processes mapping the whole
> file 1000 times per process. If we do, shooting the author seems like
> the best course of action to me.

Please, don't shoot akpm ;)

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
