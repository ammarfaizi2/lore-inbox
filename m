Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSJNQX1>; Mon, 14 Oct 2002 12:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261939AbSJNQX1>; Mon, 14 Oct 2002 12:23:27 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:39438 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261907AbSJNQX1>; Mon, 14 Oct 2002 12:23:27 -0400
Date: Mon, 14 Oct 2002 17:29:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: shadow@andrew.cmu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: AFS system call registration function take two
Message-ID: <20021014172914.A20981@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	shadow@andrew.cmu.edu, linux-kernel@vger.kernel.org
References: <3DAAD7B7.mailGKO1UAB56@johnstown.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAAD7B7.mailGKO1UAB56@johnstown.andrew.cmu.edu>; from shadow@andrew.cmu.edu on Mon, Oct 14, 2002 at 10:41:59AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd suggest you come up with an interface first.  4 longs is not
a proper syscall interface without an explanation what exactly
they do.

