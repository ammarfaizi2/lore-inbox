Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265445AbTFWIfE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 04:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbTFWIfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 04:35:04 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:54287 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265445AbTFWIfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 04:35:00 -0400
Date: Mon, 23 Jun 2003 09:49:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] loop.c - part 1 of many
Message-ID: <20030623094906.A3582@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <UTC200306230847.h5N8lZv11103.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200306230847.h5N8lZv11103.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Jun 23, 2003 at 10:47:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 10:47:35AM +0200, Andries.Brouwer@cwi.nl wrote:
> But it has already been replaced by by-name selection.
> That is what CryptoAPI does.

The last time I checked CryptoAPI did _not_ replace it but add another
level of indirection.
