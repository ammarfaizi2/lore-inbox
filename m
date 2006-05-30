Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWE3UVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWE3UVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWE3UVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:21:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42905 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932327AbWE3UVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:21:02 -0400
Date: Tue, 30 May 2006 16:20:18 -0400
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: akpm@osdl.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060530202018.GI17218@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@linux.intel.com>, akpm@osdl.org,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605301139l2b4895d0mbecffb422fb2c0cf@mail.gmail.com> <1149018946.3636.107.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149018946.3636.107.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 09:55:46PM +0200, Arjan van de Ven wrote:
 > > May 30 20:25:56 ltg01-fedora kernel: which lock already depends on the new lock,
 > 
 > ... but there was an observed code sequence before which was the other
 > way around ...

That phrase could use some rewording IMO. It sounds more like a question
than a statement.

		Dave

-- 
http://www.codemonkey.org.uk
