Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261748AbSJMU3N>; Sun, 13 Oct 2002 16:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261739AbSJMU3M>; Sun, 13 Oct 2002 16:29:12 -0400
Received: from holomorphy.com ([66.224.33.161]:9355 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261748AbSJMU2U>;
	Sun, 13 Oct 2002 16:28:20 -0400
Date: Sun, 13 Oct 2002 13:29:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: riel@surriel.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.42-mm2
Message-ID: <20021013202926.GD27878@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, riel@surriel.com,
	linux-kernel@vger.kernel.org
References: <3DA7C3A5.98FCC13E@digeo.com> <20021013101949.GB2032@holomorphy.com> <3DA9B1A7.A747ADD6@digeo.com> <20021013195236.GC27878@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021013195236.GC27878@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 12:52:36PM -0700, William Lee Irwin III wrote:
> (2) The logs still show the show_free_areas() call immediately after
> 	free_all_bootmem_core() seeing the garbage ->reserved values.

Disregard this. I reread the logs too early in the morning.


Bill
