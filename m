Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbVHaS6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVHaS6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 14:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVHaS6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 14:58:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10898 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932503AbVHaS6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 14:58:50 -0400
Subject: Re: [ANNOUNCE] DSFS Network Forensic File System for Linux Patches
From: Arjan van de Ven <arjan@infradead.org>
To: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
Cc: Rik van Riel <riel@redhat.com>, linux <linux-kernel@vger.kernel.org>
In-Reply-To: <4315E88D.9020603@soleranetworks.com>
References: <4315DBE7.7080002@soleranetworks.com>
	 <Pine.LNX.4.63.0508311432270.16968@cuia.boston.redhat.com>
	 <4315E88D.9020603@soleranetworks.com>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 20:58:36 +0200
Message-Id: <1125514716.3213.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The GPL terms that require GPL conversion of any code that runs on Linux 
> is not supported by US Law. Many would
> disagree, but that's OK. In short, it's just like any other proprietary 
> app running on Linux. If it uses no Linux code (which
> it does not), then the GPL does not apply to it .

except for section 2 which states that if parts are related (or at least
not independent, for example when they are designed to exclusively work
togethern), and one part is GPL, then both parts need to be, or you
should not distribute the GPL part. This is not "your other code becomes
gpl", it is "you can't distribute the GPL parts".



