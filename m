Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVA0KoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVA0KoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbVA0Km2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:42:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:782 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262564AbVA0Khn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:37:43 -0500
Date: Thu, 27 Jan 2005 11:37:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Vladimir Saveliev <vs@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Nikita Danilov <nikita@clusterfs.com>, linux-mm <linux-mm@kvack.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 core patches: [Was: [RFC] per thread page reservation patch]
Message-ID: <20050127103740.GD28047@stusta.de>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com> <1105019521.7074.79.camel@tribesman.namesys.com> <20050107144644.GA9606@infradead.org> <1105118217.3616.171.camel@tribesman.namesys.com> <41DEDF87.8080809@grupopie.com> <m1llb5q7qs.fsf@clusterfs.com> <20050107132459.033adc9f.akpm@osdl.org> <1106671038.4466.81.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106671038.4466.81.camel@tribesman.namesys.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

a general request:

If you add new EXPORT_SYMBOL's, I'd strongly prefer them being 
EXPORT_SYMBOL_GPL's unless there's a very good reason for an 
EXPORT_SYMBOL.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

