Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRHQWb3>; Fri, 17 Aug 2001 18:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271738AbRHQWbR>; Fri, 17 Aug 2001 18:31:17 -0400
Received: from B1eb0.pppool.de ([213.7.30.176]:40840 "HELO
	bee5.dirksteinberg.de") by vger.kernel.org with SMTP
	id <S271736AbRHQWbD> convert rfc822-to-8bit; Fri, 17 Aug 2001 18:31:03 -0400
Message-ID: <3B7D9B32.2361D4D1@dirksteinberg.de>
Date: Sat, 18 Aug 2001 00:31:14 +0200
From: "Dirk W. Steinberg" <dws@dirksteinberg.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-mosix106 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Haumer <andreas@xss.co.at>
Cc: Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@suse.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Bulent Abali <abali@us.ibm.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Swapping for diskless nodes
In-Reply-To: <Pine.LNX.4.33L.0108162146120.5646-100000@imladris.rielhome.conectiva> <3B7D8685.FE574210@xss.co.at>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Haumer wrote:
> As I promised a few days ago I have just released the newest
> version of our NBD swap patches for Linux-2.2.19.
> You can find them together with the NBD swap server and
> client source code under the following URL:
> 
> <ftp://ftp.xss.co.at/pub/Linux/NBD/nbdswap-1.2-1.tar.gz>

Hi,

do you have NBD swap patches for 2.4.x as well?
Or does it work out-of-the-box with 2.4?

Cheers,
	Dirk

------------------------------------------
Ingenieurbüro Dipl.-Ing. Dirk W. Steinberg
Ringstr. 2, D-53567 Buchholz, Germany
Phone: +49-2683-9793-20, fax: -29
Mobile/GSM: +49-170-818-9793
Email: dws@dirksteinberg.de
