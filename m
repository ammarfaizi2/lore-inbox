Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268868AbRHBJuQ>; Thu, 2 Aug 2001 05:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268869AbRHBJuG>; Thu, 2 Aug 2001 05:50:06 -0400
Received: from weta.f00f.org ([203.167.249.89]:46735 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S268868AbRHBJt5>;
	Thu, 2 Aug 2001 05:49:57 -0400
Date: Thu, 2 Aug 2001 21:50:41 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent device numbers
Message-ID: <20010802215041.B13136@weta.f00f.org>
In-Reply-To: <000901c11b1c$a87b1f40$21c9ca95@mow.siemens.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901c11b1c$a87b1f40$21c9ca95@mow.siemens.ru>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 10:30:44AM +0400, Borsenkow Andrej wrote:

    Do I miss something and Linux has such mechanism?

what problem are you trying to solve? if its disk moving about, then
you need to do things differently

anyhow, look at devfs if you really want 'static' device assignments



  --cw

