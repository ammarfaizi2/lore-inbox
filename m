Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286148AbRLTGAv>; Thu, 20 Dec 2001 01:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286157AbRLTGAo>; Thu, 20 Dec 2001 01:00:44 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:49278 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S286148AbRLTF7a>; Thu, 20 Dec 2001 00:59:30 -0500
Date: Thu, 20 Dec 2001 00:59:28 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, cs@zip.com.au, billh@tierra.ucsd.edu,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011220005928.F3682@redhat.com>
In-Reply-To: <20011219.185847.77651573.davem@redhat.com> <Pine.LNX.4.33.0112192136300.19214-100000@penguin.transmeta.com> <20011219.215730.66180642.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011219.215730.66180642.davem@redhat.com>; from davem@redhat.com on Wed, Dec 19, 2001 at 09:57:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 09:57:30PM -0800, David S. Miller wrote:
> Then let us agree to disagree. :-) I think it's potential advantages,
> and how many things really "require it" for better performance, is
> being blown out of proportion.

Show me how to make a single process server that can handle 100000 or more 
open tcp sockets that doesn't collapse under load.  I can do it with aio; 
can you do it without?

		-ben
-- 
Fish.
