Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWH1QQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWH1QQJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWH1QQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:16:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34778 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751173AbWH1QQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:16:07 -0400
Subject: Re: [PATCH 0/4] RCU: various merge candidates
From: Arjan van de Ven <arjan@infradead.org>
To: dipankar@in.ibm.com
Cc: Paul E McKenney <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060828160845.GB3325@in.ibm.com>
References: <20060828160845.GB3325@in.ibm.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 28 Aug 2006 18:15:48 +0200
Message-Id: <1156781748.3034.212.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 21:38 +0530, Dipankar Sarma wrote:
> This patchset consists of various merge candidates that would
> do well to have some testing in -mm. This patchset breaks
> out RCU implementation from its APIs to allow multiple
> implementations, 

Hi,


can you explain why we would want multiple RCU implementations?
Isn't one going to be plenty already?

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

