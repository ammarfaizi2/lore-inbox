Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289226AbSBSB1q>; Mon, 18 Feb 2002 20:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289210AbSBSB10>; Mon, 18 Feb 2002 20:27:26 -0500
Received: from holomorphy.com ([216.36.33.161]:38799 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289216AbSBSB1T>;
	Mon, 18 Feb 2002 20:27:19 -0500
Date: Mon, 18 Feb 2002 17:27:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        riel@surriel.com, davem@redhat.com, rwhron@earthlink.net
Subject: Re: [PATCH] [rmap] operator-sparse Fibonacci hashing of waitqueues
Message-ID: <20020219012710.GH3511@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org, riel@surriel.com, davem@redhat.com,
	rwhron@earthlink.net
In-Reply-To: <20020217090111.GF832@holomorphy.com> <E16cwJZ-0000jZ-00@starship.berlin> <20020219003450.GF3511@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020219003450.GF3511@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 04:34:50PM -0800, William Lee Irwin III wrote:
> Now, there is something called the "spectrum" of a number, which for
> a number x is the set of all the numbers of the form n * x, where n
> is an integer. So we have {1*x}, {2*x}, {3*x}, and so on.

Argh! Spec(x) is the multiset [1*x], [2*x], [3*x] where [x] is the
integer part of x.


Cheers,
Bill
