Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbTANKA0>; Tue, 14 Jan 2003 05:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTANKA0>; Tue, 14 Jan 2003 05:00:26 -0500
Received: from holomorphy.com ([66.224.33.161]:23429 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262089AbTANKA0>;
	Tue, 14 Jan 2003 05:00:26 -0500
Date: Tue, 14 Jan 2003 02:09:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.bk no longer boots from NFS root after bk pull this morning
Message-ID: <20030114100900.GA919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
References: <3E23E087.9020302@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E23E087.9020302@walrond.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 10:03:51AM +0000, Andrew Walrond wrote:
> 2.5 has been booting fine over NFS for ages, but after getting latest 
> stuff with a bk pull this morning, it no longer works
> Do I need to do something new, or has something busted?
> The relevant bits from dmesg are

Send in your .config, I heard a default enabled option having something
to do with "GSS" isn't playing nicely with others.


Bill
