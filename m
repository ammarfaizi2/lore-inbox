Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135953AbRDZWFZ>; Thu, 26 Apr 2001 18:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135954AbRDZWFQ>; Thu, 26 Apr 2001 18:05:16 -0400
Received: from pa176.jeleniag.ppp.tpnet.pl ([212.160.39.176]:13953 "HELO
	marek.almaran.home") by vger.kernel.org with SMTP
	id <S135953AbRDZWFF>; Thu, 26 Apr 2001 18:05:05 -0400
Date: Fri, 27 Apr 2001 00:04:08 +0200
From: =?iso-8859-2?Q?Marek_P=EAtlicki?= <marpet@buy.pl>
To: Wayne.Brown@altec.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: binfmt_misc on 2.4.3-ac14
Message-ID: <20010427000408.A1882@marek.almaran.home>
In-Reply-To: <86256A3A.00771A06.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <86256A3A.00771A06.00@smtpnotes.altec.com>; from Wayne.Brown@altec.com on Thu, Apr 26, 2001 at 11:42:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April, 2001-04-26 at 23:42:08, Wayne.Brown@altec.com wrote:
> 
> 
> Marek P
> 
> êtlicki <marpet@buy.pl> wrote:
> 
> >The directory /proc/sys/fs/binfmt_misc/ exists, but nothing in it.
> 
> Try this:
> 
> mount -t binfmt_misc none /proc/sys/fs/binfmt_misc

thank you very much :-)

is it going to become the default in future kernel releases?

regards

-- 
Marek Pêtlicki <marpet@buy.pl>

