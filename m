Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbRGHRG3>; Sun, 8 Jul 2001 13:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbRGHRGT>; Sun, 8 Jul 2001 13:06:19 -0400
Received: from metastasis.f00f.org ([203.167.249.89]:17538 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266930AbRGHRGF>;
	Sun, 8 Jul 2001 13:06:05 -0400
Date: Mon, 9 Jul 2001 05:05:54 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Adam <adam@eax.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: recvfrom and sockaddr_in.sin_port
Message-ID: <20010709050554.B28809@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0107081155100.1430-200000@eax.student.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107081155100.1430-200000@eax.student.umd.edu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2001 at 12:14:47PM -0500, Adam wrote:

    	I have attached a simple program I used for generating those
    	results.

'fromlen' needs to be set to sizeof 'from' before the recvfrom syscall



  --cw
