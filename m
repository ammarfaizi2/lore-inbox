Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262094AbSJTV7N>; Sun, 20 Oct 2002 17:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262141AbSJTV7N>; Sun, 20 Oct 2002 17:59:13 -0400
Received: from 213-97-199-90.uc.nombres.ttd.es ([213.97.199.90]:26789 "HELO
	fargo") by vger.kernel.org with SMTP id <S262094AbSJTV7M>;
	Sun, 20 Oct 2002 17:59:12 -0400
From: "David =?ISO-8859-1?Q?G=F3mez=22?= <david@pleyades.net>"@vax.home.local
Date: Mon, 21 Oct 2002 00:04:10 +0200
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pre-decoded wchan output
Message-ID: <20021020220410.GA32034@fargo>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
References: <1034882043.1072.589.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1034882043.1072.589.camel@phantasy>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 17 at 03:14:02, Robert Love wrote:
> Which is damn cool to me and will let ps(1) grab wchan information
> without having to parse System.map.  It also means procps will not need
> System.map.

Hope this patch gets included in kernel 2.5 ;). I think is very nice to make
ps not to depend on System.map for resolving wchan. I'll give a try to your
patch right now.

-- 
David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra
