Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTESLHC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 07:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTESLHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 07:07:02 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:62704 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S262385AbTESLHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 07:07:01 -0400
Subject: Re: Recent changes to sysctl.h breaks glibc
From: Martin Schlemmer <azarah@gentoo.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Christoph Hellwig <hch@infradead.org>, KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030519105152.GD8978@holomorphy.com>
References: <1053289316.10127.41.camel@nosferatu.lan>
	 <20030518204956.GB8978@holomorphy.com>
	 <1053292339.10127.45.camel@nosferatu.lan>
	 <20030519063813.A30004@infradead.org>
	 <1053341023.9152.64.camel@workshop.saharact.lan>
	 <20030519105152.GD8978@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1053342842.9152.90.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 19 May 2003 13:14:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 12:51, William Lee Irwin III wrote:

> IIRC you're supposed to use some sort of sanitized copy, not the things
> directly. IMHO the current state of affairs sucks as there is no
> standard set of ABI headers, but grabbing them right out of the kernel
> is definitely not the way to go.
> 

Ok, anybody know of an effort to get this done ?

Also, what about odd things that are more kernel dependant
like imon support in fam for example ?  The imon.h will not
be in the 'sanitized copy' ....


Regards,

-- 
Martin Schlemmer


