Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTENMdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbTENMdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:33:06 -0400
Received: from holomorphy.com ([66.224.33.161]:13763 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262016AbTENMdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:33:04 -0400
Date: Wed, 14 May 2003 05:45:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] PAG support, try #2
Message-ID: <20030514124534.GO2444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Howells <dhowells@warthog.cambridge.redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20030514115653.A15202@infradead.org> <30949.1052913364@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30949.1052913364@warthog.warthog>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 12:56:04PM +0100, David Howells wrote:
> There won't be many PAGs. Basically one per login session would be fairly
> typical, and possibly one per SUID program run at some later date.

That's very reassuring to me, thanks for clearing that up.


-- wli
