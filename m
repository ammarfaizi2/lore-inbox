Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLKWnI>; Mon, 11 Dec 2000 17:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbQLKWm6>; Mon, 11 Dec 2000 17:42:58 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:30480 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S131010AbQLKWmx>; Mon, 11 Dec 2000 17:42:53 -0500
Date: Mon, 11 Dec 2000 23:12:21 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
Message-ID: <20001211231221.C30911@vega.digitel2002.hu>
In-Reply-To: <m2k896rfg4.fsf@localhost.yi.org.> <Pine.LNX.4.21.0012111636040.4808-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012111636040.4808-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Mon, Dec 11, 2000 at 04:38:11PM -0200
X-Operating-System: vega Linux 2.2.18pre24 i686
From: Gabor Lenart <lgb@vega.digitel2002.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2000 at 04:38:11PM -0200, Rik van Riel wrote:
> On 11 Dec 2000, John Fremlin wrote:
> 
> > Two points: 		[snipped]
> 
> 
> Doing a 'make bzImage' is NOT VM-intensive. Using this as a test
> for the VM doesn't make any sense since it doesn't really excercise
> the VM in any way...

Also, you should view the result of some hdd benchmarks because
it's possible to get different values for 2.4 and 2.2 which is major
point for a fair test (maybe 2.4 and 2.2 have got different default values
and so on. try hdparm -tT /dev/hd? if you have got IDE disks).

-- 
 ---[ Gábor Lénárt ]----[ Vivendi Telecom Hungary ]---[ lgb@supervisor.hu ]---
 U have 8 bit computer or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]--------> LGB <-------[ Linux/UNIX/8bit 4ever ]-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
