Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262408AbSJKIEs>; Fri, 11 Oct 2002 04:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbSJKIEr>; Fri, 11 Oct 2002 04:04:47 -0400
Received: from tapu.f00f.org ([66.60.186.129]:33931 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262408AbSJKIEr>;
	Fri, 11 Oct 2002 04:04:47 -0400
Date: Fri, 11 Oct 2002 01:10:33 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Gerhard Mack <gmack@innerfire.net>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021011081033.GA29765@tapu.f00f.org>
References: <20021010224739.GB2673@matchmail.com> <Pine.LNX.4.44.0210102214060.16542-100000@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210102214060.16542-100000@innerfire.net>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 10:14:37PM -0400, Gerhard Mack wrote:

> Correct however it seems to be what shoves everything out of the
> cache every night.

Because it reads all your metadata ... O_STREAMING won't help here.


  --cw

