Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbSKMJG6>; Wed, 13 Nov 2002 04:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267146AbSKMJG6>; Wed, 13 Nov 2002 04:06:58 -0500
Received: from holomorphy.com ([66.224.33.161]:62143 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267145AbSKMJG5>;
	Wed, 13 Nov 2002 04:06:57 -0500
Date: Wed, 13 Nov 2002 01:11:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.47-mm2
Message-ID: <20021113091116.GG23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <3DD21113.B4F3857@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD21113.B4F3857@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 12:45:07AM -0800, Andrew Morton wrote:
> page-reservation.patch
>   Page reservation API

Don't drop it yet, I've got a caller of this on the back burner.


Bill
