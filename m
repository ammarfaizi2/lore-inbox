Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUEKGT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUEKGT3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUEKGT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:19:29 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:14085 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262114AbUEKGSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:18:47 -0400
Date: Tue, 11 May 2004 07:18:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040511071844.A12187@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
	linux-kernel@vger.kernel.org
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org> <20040510231146.GA5168@taniwha.stupidest.org> <20040510162818.376b4a55.akpm@osdl.org> <20040510233342.GA5614@taniwha.stupidest.org> <20040510165132.5107472e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040510165132.5107472e.akpm@osdl.org>; from akpm@osdl.org on Mon, May 10, 2004 at 04:51:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What I wish to do is to ensure that all users receive the *same* nasty
> workaround.  Call it damage control.

It's not damage control.  It increases the damage as we have to support
that hack now forever.

