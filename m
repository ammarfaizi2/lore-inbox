Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbSJOVLO>; Tue, 15 Oct 2002 17:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSJOVKM>; Tue, 15 Oct 2002 17:10:12 -0400
Received: from holomorphy.com ([66.224.33.161]:23192 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264849AbSJOVI6>;
	Tue, 15 Oct 2002 17:08:58 -0400
Date: Tue, 15 Oct 2002 14:11:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fewer unlikely tests
Message-ID: <20021015211102.GB24068@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210152210030.1521-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210152210030.1521-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 10:11:44PM +0100, Hugh Dickins wrote:
> Occasionally I worry about all those BUG_ON tests we keep adding into
> page_alloc.c.  This patch does one preliminary test of all the flags
> before trying individually.  Maybe you consider this in bad taste,
> or maybe you think it's worthwhile: as you wish.

Reasonable and straightforward IMHO.


Bill
