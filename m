Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVDLO5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVDLO5k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVDLOxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:53:30 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:51097 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S262430AbVDLOvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:51:22 -0400
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] genalloc for 2.6.12-rc-mm3
References: <16987.39669.285075.730484@jaguar.mkp.net>
	<20050412031502.3b5d39fc.akpm@osdl.org>
	<yq0br8k12nd.fsf@jaguar.mkp.net> <20050412144720.GA19894@lst.de>
From: Jes Sorensen <jes@wildopensource.com>
Date: 12 Apr 2005 10:51:20 -0400
In-Reply-To: <20050412144720.GA19894@lst.de>
Message-ID: <yq03btw121j.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

>> +#include <asm/pal.h>
Christoph> this will break on all plattforms except alpha and ia64.

The driver is located in arch/ia64/kernel/ ;-)

Cheers,
Jes
