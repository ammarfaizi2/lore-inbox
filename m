Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbSLBRtj>; Mon, 2 Dec 2002 12:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbSLBRtj>; Mon, 2 Dec 2002 12:49:39 -0500
Received: from [198.149.18.6] ([198.149.18.6]:38538 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S264672AbSLBRtj>;
	Mon, 2 Dec 2002 12:49:39 -0500
Date: Mon, 2 Dec 2002 20:11:01 -0500
From: Christoph Hellwig <hch@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: marcelo@connectiva.com.br.munich.sgi.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021202201101.A26164@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, marcelo@connectiva.com.br,
	rml@tech9.net, linux-kernel@vger.kernel.org
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1919608311.1038822649@[10.10.2.3]>; from mbligh@aracnet.com on Mon, Dec 02, 2002 at 09:50:50AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 09:50:50AM -0800, Martin J. Bligh wrote:
> There was talk of merging the O(1) scheduler into 2.4 at OLS.
> If every distro has it, and 2.5 has it, and it's been around for
> this long, I think that proves it stable.
> 
> Marcelo, what are the chances of getting this merged into mainline
> in the 2.4.20 timeframe?

Ingo vetoed it.

