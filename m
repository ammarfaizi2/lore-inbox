Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262043AbSJHLdh>; Tue, 8 Oct 2002 07:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262048AbSJHLdh>; Tue, 8 Oct 2002 07:33:37 -0400
Received: from holomorphy.com ([66.224.33.161]:34782 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262043AbSJHLdg>;
	Tue, 8 Oct 2002 07:33:36 -0400
Date: Tue, 8 Oct 2002 04:36:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: akpm@zip.com.au, Martin.Bligh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.41: i386/mm/discontig.c doesn't compile with CONFIG_HIGHMEM
Message-ID: <20021008113620.GE12432@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Adrian Bunk <bunk@fs.tum.de>, akpm@zip.com.au,
	Martin.Bligh@us.ibm.com, linux-kernel@vger.kernel.org
References: <Pine.NEB.4.44.0210081241140.8340-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0210081241140.8340-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 12:45:05PM +0200, Adrian Bunk wrote:
> FYI:
> The compilation of arch/i386/mm/discontig.c fails in both 2.5.41 and
> 2.5.41-ac1 with the following error when CONFIG_HIGHMEM is enabled:
> <--  snip  -->

Fix already sent to akpm.

Date:   Sat, 5 Oct 2002 17:05:33 -0700
From:   William Lee Irwin III <wli@holomorphy.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@zip.com.au
Subject: 2.5.40 snapshot ia32 discontig compilefix
Message-ID: <20021006000533.GE12432@holomorphy.com>



Bill
