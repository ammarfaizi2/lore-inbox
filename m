Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316458AbSEOSbo>; Wed, 15 May 2002 14:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316467AbSEOSbn>; Wed, 15 May 2002 14:31:43 -0400
Received: from holomorphy.com ([66.224.33.161]:60578 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316458AbSEOSbm>;
	Wed, 15 May 2002 14:31:42 -0400
Date: Wed, 15 May 2002 11:30:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] iowait statistics
Message-ID: <20020515183004.GG27957@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <200205151514.g4FFEmY13920@Port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44L.0205151310130.9490-100000@duckman.distro.conectiva> <20020515170025.GF27957@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 10:00:25AM -0700, William Lee Irwin III wrote:
> Wed May 15 09:58:22 PDT 2002
> cpu  98583 0 8082 204779 9328
> cpu0 24538 0 2254 51205 2298
> cpu1 24521 0 2065 51180 2393
> cpu2 24704 0 1978 51230 2247
> cpu3 24820 0 1785 51164 2390
> 
> It looks very constant, not sure if it should be otherwise.

Not quite constant, just slowly varying:

Wed May 15 11:30:47 PDT 2002
cpu  2095183 0 158967 263950 20705
cpu0 524201 0 40781 64795 5026
cpu1 523034 0 39953 66328 5352
cpu2 525737 0 37989 65826 5115
cpu3 522211 0 40244 67001 5212


Cheers,
Bill
