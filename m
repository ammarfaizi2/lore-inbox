Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVFHRrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVFHRrc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVFHRrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:47:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23461 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261470AbVFHRqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:46:50 -0400
Date: Wed, 8 Jun 2005 18:46:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Scott Bardone <sbardone@chelsio.com>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
Message-ID: <20050608174640.GA14954@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Scott Bardone <sbardone@chelsio.com>,
	Lukas Hejtmanek <xhejtman@mail.muni.cz>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20050607181300.GL2369@mail.muni.cz> <42A5EC7C.4020202@pobox.com> <20050607185845.GM2369@mail.muni.cz> <42A5F51B.5060909@pobox.com> <20050607193305.GN2369@mail.muni.cz> <20050607200820.GA25546@electric-eye.fr.zoreil.com> <20050607211048.GO2369@mail.muni.cz> <42A655C2.3030406@chelsio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A655C2.3030406@chelsio.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 07:19:46PM -0700, Scott Bardone wrote:
> We currently don't have the TOE API in the Linux kernel so the TOE 
> functionality does not exist, therefore you can only use the Chelsio 
> modified 2.6.6 kernel for TOE.

Care to explain what modifications you do, and whether or not you consider
your card firmware a derived work of the TCP stack because of them?

