Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWCOKYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWCOKYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 05:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWCOKYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 05:24:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64444 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932194AbWCOKYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 05:24:34 -0500
Subject: Re: Patch 2/9] Initialization
From: Arjan van de Ven <arjan@infradead.org>
To: nagar@watson.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1142297101.5858.10.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142297101.5858.10.camel@elinux04.optonline.net>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 11:24:32 +0100
Message-Id: <1142418273.3021.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2.1 of the GNU Lesser General Public License
> + * as published by the Free Software Foundation.
> + *

LGPL inside the kernel doesn't make a whole lot of sense.... better make
it GPL.

