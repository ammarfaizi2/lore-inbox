Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbTLCP1Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264926AbTLCP1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:27:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6318 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264913AbTLCP1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:27:14 -0500
Date: Wed, 3 Dec 2003 16:27:13 +0100
From: Jan Kara <jack@suse.cz>
To: Steven Cole <elenstev@mesatop.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.23 update Documentation/Changes for quota-tools
Message-ID: <20031203152713.GA27475@atrey.karlin.mff.cuni.cz>
References: <1070464274.1652.24.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070464274.1652.24.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch updates Documentation/Changes for quota-tools.  
> 
> This information may be needed by those wanting to use the new quota
> code (CONFIG_QFMT_V2) which went in about 6 months ago.
> 
> The patch to update ver_linux for quota-tools was applied 5 months ago,
> but this part slipped through the cracks somehow.
  The patch looks right (though you need newer quota tools mainly
because the interface to QFMT_V2 has changed also due to other problems
than just 32-bit uids but I'd leave the text as is and not complicate
the explanations...). Marcello, please apply it.

									Honza

