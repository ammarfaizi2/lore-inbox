Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288998AbSANTaY>; Mon, 14 Jan 2002 14:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288990AbSANT3F>; Mon, 14 Jan 2002 14:29:05 -0500
Received: from mout04.kundenserver.de ([195.20.224.89]:1608 "EHLO
	mout04.kundenserver.de") by vger.kernel.org with ESMTP
	id <S288981AbSANT2c>; Mon, 14 Jan 2002 14:28:32 -0500
Date: Mon, 14 Jan 2002 20:29:25 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: slowdown with new scheduler.
Message-ID: <20020114192925.GA4441@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020114124541.A32412@suse.de> <20020114172010.GA173@elfie.cavy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114172010.GA173@elfie.cavy.de>
User-Agent: Mutt/1.3.25-current-20020102i (Linux 2.4.18-pre3 i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jan 14 2002, Heinz Diehl wrote:

> 2.4.18-pre3	 	    real    7m55.243s
> 			    user    6m34.080s
> 			    sys     0m27.610s
> 
> 2.4.18-pre+H7		    real    7m35.962s
> 			    user    6m34.270s
> 			    sys     0m27.700s
> 
> 2.4.18-pre3-ac2	    real    7m39.203s
> 			    user    6m34.110s
> 			    sys     0m28.740s
> 

2.4.18-pre3+H7+preempt-rml  real    6m58.983s
 			    user    6m34.500s
 			    sys     0m27.820s

:))

-- 
# Heinz Diehl, 68259 Mannheim, Germany
