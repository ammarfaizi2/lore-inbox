Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTDFJnG (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 05:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbTDFJnG (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 05:43:06 -0400
Received: from holomorphy.com ([66.224.33.161]:56473 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262888AbTDFJnF (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 05:43:05 -0400
Date: Sun, 6 Apr 2003 01:54:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@digeo.com>,
       andrea@suse.de, mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030406095409.GL993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@digeo.com>,
	andrea@suse.de, mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com,
	dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405232524.GD1828@holomorphy.com> <20030406052603.A4440@redhat.com> <20030406094128.GK993@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030406094128.GK993@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 01:41:28AM -0800, William Lee Irwin III wrote:
> All this said, the drivers and the arch code bits are actually largely
> trivial substitions. If the discussion is truly limited to that, I'm
> okay with sending in pieces; still it makes me uneasy to do anything
> while the code I have now is so far from working as it truly should.

Also, part of this is prior agreement with Hugh (the originator of the
2.4.x version of the stuff) and akpm to withhold merging until full
functionality is achieved.

IMHO this full functionality has not been achieved, even though some
demonstrations of broadened hardware support benefits are feasible.

To both respect this agreement and remain within the bounds of my own
coding ethics, I should refuse to merge until both a greater degree of
completeness of implementation and a far greater degree of code
cleanliness is achieved.


-- wli
