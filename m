Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262637AbTDAQno>; Tue, 1 Apr 2003 11:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbTDAQno>; Tue, 1 Apr 2003 11:43:44 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:46600 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262637AbTDAQnm>; Tue, 1 Apr 2003 11:43:42 -0500
Date: Tue, 1 Apr 2003 17:55:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: bcrl@redhat.com, akpm@digeo.com, linux-fsdevel@vger.kernel.org,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Filesystem aio rdwr patchset
Message-ID: <20030401175502.B19660@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>, bcrl@redhat.com,
	akpm@digeo.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-kernel@vger.kernel.org
References: <20030401215957.A1800@in.ibm.com> <20030401220242.B1857@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030401220242.B1857@in.ibm.com>; from suparna@in.ibm.com on Tue, Apr 01, 2003 at 10:02:42PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +int blk_congestion_wait_async(int rw, long timeout)

Isn't the name a bit silly? :)

