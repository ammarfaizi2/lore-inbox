Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTJOVhK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 17:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTJOVhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 17:37:09 -0400
Received: from holomorphy.com ([66.224.33.161]:22913 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261928AbTJOVhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 17:37:07 -0400
Date: Wed, 15 Oct 2003 14:40:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test7-mm1
Message-ID: <20031015214004.GC723@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031015013649.4aebc910.akpm@osdl.org> <1066232576.25102.1.camel@telecentrolivre> <20031015165508.GA723@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015165508.GA723@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 09:55:08AM -0700, William Lee Irwin III wrote:
> Okay, this one's me. I should have tried DEBUG_PAGEALLOC when testing.

I can't reproduce it here, can you retry with the invalidate_inodes-speedup
patch backed out?


-- wli
