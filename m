Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289139AbSAGMtf>; Mon, 7 Jan 2002 07:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289148AbSAGMt0>; Mon, 7 Jan 2002 07:49:26 -0500
Received: from dsl-213-023-038-159.arcor-ip.net ([213.23.38.159]:51725 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289139AbSAGMtR>;
	Mon, 7 Jan 2002 07:49:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>,
        Peter W?chtler <pwaechtler@loewe-komp.de>
Subject: Re: [PATCH] updated version of radix-tree pagecache
Date: Mon, 7 Jan 2002 13:52:18 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Christoph Hellwig <hch@caldera.de>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>, velco@fadata.bg
In-Reply-To: <20020105171234.A25383@caldera.de> <3C3972D4.56F4A1E2@loewe-komp.de> <20020107030344.H10391@holomorphy.com>
In-Reply-To: <20020107030344.H10391@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NZGK-0001Q1-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2002 12:03 pm, William Lee Irwin III wrote:
> Christoph Hellwig schrieb:
> >> [please Cc velco@fadata.bg and lkml on reply]
> >> 
> >> I've just uploaded an updated version of Momchil Velikov's patch for a
> >> scalable pagecache using radix trees.  The patch can be found at:
> >> 
> >> It contains a number of fixed and improvements by Momchil and me.
