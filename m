Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266132AbUGIL42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266132AbUGIL42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUGIL42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:56:28 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:50328 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266132AbUGIL41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:56:27 -0400
Date: Fri, 9 Jul 2004 12:55:31 +0100
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Erik Rigtorp <erik@rigtorp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp bootsplash support
Message-ID: <20040709115531.GA28343@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	Erik Rigtorp <erik@rigtorp.com>, linux-kernel@vger.kernel.org
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org> <20040708204840.GB607@openzaurus.ucw.cz> <20040708210403.GA18049@infradead.org> <20040708225216.GA27815@elf.ucw.cz> <20040708225501.GA20143@infradead.org> <20040709051528.GB23152@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709051528.GB23152@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 07:15:28AM +0200, Pavel Machek wrote:

 > But I guess swsusp is going to make this more "interesting" as
 > progressbar is nice to have there, and userland can not help at that
 > point.

Personally I'd prefer the effort went into making suspend actually
work on more machines rather than painting eyecandy for the minority
of machines it currently works on.

		Dave

