Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318358AbSIBTJZ>; Mon, 2 Sep 2002 15:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318366AbSIBTJZ>; Mon, 2 Sep 2002 15:09:25 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:33798 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318358AbSIBTJZ>; Mon, 2 Sep 2002 15:09:25 -0400
Date: Mon, 2 Sep 2002 20:13:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: janul@wp.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG at page_alloc.c:91!
Message-ID: <20020902201355.A10519@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, janul@wp.pl,
	linux-kernel@vger.kernel.org
References: <20020902190641.GA8645@janul>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020902190641.GA8645@janul>; from janul@wp.pl on Mon, Sep 02, 2002 at 09:06:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 09:06:41PM +0200, janul@wp.pl wrote:
> [1.]
> can't run logcheck (Segmentation fault): kernel BUG at page_alloc.c:91!

Please unload the nvidia driver and retry.

