Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311175AbSCLNH3>; Tue, 12 Mar 2002 08:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311176AbSCLNHT>; Tue, 12 Mar 2002 08:07:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:28362 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311175AbSCLNHJ>;
	Tue, 12 Mar 2002 08:07:09 -0500
Date: Tue, 12 Mar 2002 05:03:38 -0800 (PST)
Message-Id: <20020312.050338.124588076.davem@redhat.com>
To: dean-list-linux-kernel@arctic.org
Cc: michael@metaparadigm.com, bcrl@redhat.com, whitney@math.berkeley.edu,
        rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: [patch] ns83820 0.17
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0203120457300.27360-100000@twinlark.arctic.org>
In-Reply-To: <20020312.031509.53067416.davem@redhat.com>
	<Pine.LNX.4.33.0203120457300.27360-100000@twinlark.arctic.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: dean gaudet <dean-list-linux-kernel@arctic.org>
   Date: Tue, 12 Mar 2002 05:03:45 -0800 (PST)

   On Tue, 12 Mar 2002, David S. Miller wrote:
   
   > Use a cross-over cable to play with Jumbo frames, that is
   > what I do :-)
   
   you shouldn't even need a crossover cable :)

Intel e1000's can do this too...

come to think of it there is a link polarity bit in one
of the tigon3 registers, hmmm...

