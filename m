Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbRGHRV3>; Sun, 8 Jul 2001 13:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266934AbRGHRVT>; Sun, 8 Jul 2001 13:21:19 -0400
Received: from metastasis.f00f.org ([203.167.249.89]:20098 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S265051AbRGHRVK>;
	Sun, 8 Jul 2001 13:21:10 -0400
Date: Mon, 9 Jul 2001 05:21:00 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Adam <adam@cfar.umd.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: recvfrom and sockaddr_in.sin_port
Message-ID: <20010709052100.E28809@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0107081307570.936-100000@eax.student.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107081307570.936-100000@eax.student.umd.edu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2001 at 01:08:37PM -0500, Adam wrote:

    isn't it set? to quote from the example I have attached:
    
      socklen_t fromlen = sizeof(struct sockaddr_in);

sorry, I misread the source (the memset line)

you are using raw sockets, what does port mean for raw sockets?



  --cw
