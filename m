Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289839AbSA2Th2>; Tue, 29 Jan 2002 14:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289840AbSA2ThS>; Tue, 29 Jan 2002 14:37:18 -0500
Received: from holomorphy.com ([216.36.33.161]:33694 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289839AbSA2ThK>;
	Tue, 29 Jan 2002 14:37:10 -0500
Date: Tue, 29 Jan 2002 11:38:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@caldera.de>, linux-mm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hashed page waitqueues for 2.5
Message-ID: <20020129113855.I899@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@caldera.de>, linux-mm@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020129113058.A7423@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020129113058.A7423@caldera.de>; from hch@caldera.de on Tue, Jan 29, 2002 at 11:30:58AM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 11:30:58AM +0100, Christoph Hellwig wrote:
> William Lee Irwin III's seems to be almost unnotices in the
> mainline although it is merged in Rik's -rmap tree.
> 
> The below patch is based on his latest 2.4.17 patch + my wake_up_page
> change from -rmap12.  It applies against 2.5.3-pre{5,6} (atleast).
> 
> I'd be happy if everyone could take a look at it.
> 
> 	Christoph

Looks good to me. Thanks for the 2.5 port. =)

Cheers,
Bill
