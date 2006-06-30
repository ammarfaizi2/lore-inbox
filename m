Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbWF3RWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbWF3RWG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 13:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWF3RWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 13:22:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5587 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932620AbWF3RWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 13:22:05 -0400
Subject: Re: problem with new kernel
From: Arjan van de Ven <arjan@infradead.org>
To: eclark <eclark@alabanza.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606301310.48075.eclark@alabanza.com>
References: <200606301046.17526.eclark@alabanza.com>
	 <1151685938.11434.51.camel@laptopd505.fenrus.org>
	 <200606301310.48075.eclark@alabanza.com>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 19:22:02 +0200
Message-Id: <1151688123.11434.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 13:10 -0400, eclark wrote:
> Excellent! How do I get NPTL built into the kernel.

realistically NPTL on 2.4 is a real big pain in the <>. So I would
suggest to either use a distribution kernel with NPTL patched in, or use
a 2.6 kernel. Making your own NPTL patch for 2.4.. lets say it would
take a really really experienced kernel hacker at least 3 weeks... and
stability would be.. brittle. Just don't go there ;(

Greetings,
   Arjan van de Ven

