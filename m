Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSEUSpR>; Tue, 21 May 2002 14:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSEUSpQ>; Tue, 21 May 2002 14:45:16 -0400
Received: from holomorphy.com ([66.224.33.161]:10894 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315420AbSEUSpP>;
	Tue, 21 May 2002 14:45:15 -0400
Date: Tue, 21 May 2002 11:45:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: lazy buddy prototype
Message-ID: <20020521184509.GG2046@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020521175005.GN2035@holomorphy.com> <20020521183628.GF2046@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 10:50:05AM -0700, William Lee Irwin III wrote:
>> TODO:
> [...]
>> (13) figure out some way to get fragmentation stats out of the buddy bitmap

On Tue, May 21, 2002 at 11:36:28AM -0700, William Lee Irwin III wrote:
> And an important omission, of which Andrew Morton reminded me:
> (14) document it

and from Ben LaHaise:

(15) collect statistics on the allocation rates for various orders

and concomitant to this:

(16) collect statistics on allocation failures due to fragmentation


Cheers,
Bill
