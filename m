Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313083AbSEHLCh>; Wed, 8 May 2002 07:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313032AbSEHLCg>; Wed, 8 May 2002 07:02:36 -0400
Received: from holomorphy.com ([66.224.33.161]:35201 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S313019AbSEHLCf>;
	Wed, 8 May 2002 07:02:35 -0400
Date: Wed, 8 May 2002 04:01:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin.Knoblauch" <Martin.Knoblauch@teraport.de>
Cc: rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preemptive kernel for 2.4.19-pre7-ac4
Message-ID: <20020508110115.GW32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin.Knoblauch" <Martin.Knoblauch@teraport.de>, rml@tech9.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205081259.17948.Martin.Knoblauch@teraport.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 12:59:17PM +0200, Martin.Knoblauch wrote:
> What about lock-break for the -ac series? Or does this conflict with rmap 
> and/or O(1)?

Speaking from experience, it's trivial to port it to either of those, or
a combination of both.


Cheers,
Bill
