Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSFXTaP>; Mon, 24 Jun 2002 15:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315191AbSFXTaP>; Mon, 24 Jun 2002 15:30:15 -0400
Received: from holomorphy.com ([66.224.33.161]:47820 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315182AbSFXTaO>;
	Mon, 24 Jun 2002 15:30:14 -0400
Date: Mon, 24 Jun 2002 12:29:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: akpm@zip.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: RFC: turn scatterlist into a linked list, eliminate bio_vec
Message-ID: <20020624192934.GJ22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Adam J. Richter" <adam@yggdrasil.com>, akpm@zip.com.au,
	axboe@suse.de, linux-kernel@vger.kernel.org
References: <200206232358.QAA03027@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200206232358.QAA03027@adam.yggdrasil.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2002 at 04:58:20PM -0700, Adam J. Richter wrote:
> 	The idea is to turn struct scatterlist from an array into a
> linked list.  Here are some advantages:

I'm all for it, though I wonder sometimes if a tree might be better.


Cheers,
Bill
