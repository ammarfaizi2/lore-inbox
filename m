Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289116AbSA1F1m>; Mon, 28 Jan 2002 00:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289117AbSA1F1Y>; Mon, 28 Jan 2002 00:27:24 -0500
Received: from holomorphy.com ([216.36.33.161]:3222 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289116AbSA1F1N>;
	Mon, 28 Jan 2002 00:27:13 -0500
Date: Sun, 27 Jan 2002 21:28:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rik van Riel's vm-rmap
Message-ID: <20020127212838.F899@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Louis Garcia <louisg00@bellsouth.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1012193811.24890.4.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <1012193811.24890.4.camel@tiger>; from louisg00@bellsouth.net on Sun, Jan 27, 2002 at 11:56:50PM -0500
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2002 at 11:56:50PM -0500, Louis Garcia wrote:
> Does he still use classzones as the basis for the vm? I thought that
> linux was trying to get away from classzones for better NUMA support in
> 2.5??

rmap does not use the classzone concept.


Cheers,
Bill
