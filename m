Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264438AbTEPPOB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 11:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbTEPPOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 11:14:01 -0400
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:57041 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id S264438AbTEPPN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 11:13:59 -0400
To: Nathan Neulinger <nneul@umr.edu>
Cc: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support only
References: <8943.1052843591@warthog.warthog>
	<20030513213759.A9244@infradead.org>
	<1052864839.20037.2.camel@nneul-laptop>
From: Derek Atkins <warlord@MIT.EDU>
Date: 16 May 2003 11:24:02 -0400
In-Reply-To: <1052864839.20037.2.camel@nneul-laptop>
Message-ID: <sjmaddmewz1.fsf@kikki.mit.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Neulinger <nneul@umr.edu> writes:

> Per pag on most clients will only have a single token, but number of
> pags will depend totally on the nature of the machine. 

Uh, no, at least around MIT per-pag users usually have about 2-3
tokens on average.  I've run with as many as 10.  Please do not assume
some max. number of tokens in a pag.

> I also have machines that have a few hundred pags around that don't have
> any tokens in them, but could at any time.
> 
> -- Nathan

-- 
       Derek Atkins, SB '93 MIT EE, SM '95 MIT Media Laboratory
       Member, MIT Student Information Processing Board  (SIPB)
       URL: http://web.mit.edu/warlord/    PP-ASEL-IA     N1NWH
       warlord@MIT.EDU                        PGP key available
