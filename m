Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWDYUh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWDYUh7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWDYUh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:37:59 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:38533 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932300AbWDYUh6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:37:58 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 1/2] strstrip API
Date: Tue, 25 Apr 2006 22:35:24 +0200
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, holzheu@de.ibm.com, joern@wohnheim.fh-wedel.de,
       minyard@acm.org, linux-kernel@vger.kernel.org
References: <1145956265.27659.22.camel@localhost>
In-Reply-To: <1145956265.27659.22.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604252235.25803.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On Tuesday, 25. April 2006 11:11, Pekka Enberg wrote:
> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> This patch adds a new strstrip() function to lib/string.c for removing
> leading and trailing whitespace from a string.
> 
> Cc: Michael Holzheu <holzheu@de.ibm.com>
> Cc: Ingo Oeser <ioe-lkml@rameria.de>
> Cc: Jörn Engel <joern@wohnheim.fh-wedel.de>
> Cc: Corey Minyard <minyard@acm.org>
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

Acked-by: Ingo Oeser <ioe-lkml@rameria.de>

Simple enough and fits all users so far.
Good work!


Regards

Ingo Oeser
