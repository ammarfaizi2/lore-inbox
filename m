Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312358AbSCZQoi>; Tue, 26 Mar 2002 11:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312366AbSCZQoV>; Tue, 26 Mar 2002 11:44:21 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:64942 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S312358AbSCZQoQ>; Tue, 26 Mar 2002 11:44:16 -0500
Date: Tue, 26 Mar 2002 10:00:39 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
Subject: Re: Putrid Elevator Behavior 2.4.18/19
Message-ID: <20020326100039.A20176@vger.timpanogas.org>
In-Reply-To: <20020320120455.A19074@vger.timpanogas.org> <20020320220241.GC29857@matchmail.com> <20020320152008.A19978@vger.timpanogas.org> <20020320152504.B19978@vger.timpanogas.org> <3C9935CA.38E6F56F@zip.com.au> <20020320234552.A21740@vger.timpanogas.org> <20020325181645.A17171@vger.timpanogas.org> <20020325174555.A3252@greenhydrant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Did upgrading to 2.4.19-pre4 by itself fix your problems, or did you need to
> tweak with elvtune as well?  If so, what values did you find produced
> optimal results?
> 
> -Dave


Defaults with the updated patch seen to work fine.

Jeff


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
