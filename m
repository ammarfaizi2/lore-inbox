Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263415AbRFAIS0>; Fri, 1 Jun 2001 04:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263414AbRFAISQ>; Fri, 1 Jun 2001 04:18:16 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:12549 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S263413AbRFAISA>; Fri, 1 Jun 2001 04:18:00 -0400
Date: Fri, 1 Jun 2001 20:17:56 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Ralf Baechle <ralf@uni-koblenz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to know HZ from userspace?
Message-ID: <20010601201756.A12423@metastasis.f00f.org>
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva> <9f41vq$our$1@cesium.transmeta.com> <20010601035739.A1630@bacchus.dhis.org> <9f74mg$1it$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9f74mg$1it$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, May 31, 2001 at 09:12:00PM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2001 at 09:12:00PM -0700, H. Peter Anvin wrote:

    Please do.

Well, I was quite keen on this (I often run with HZ==2048 and have to
have a hacked procps to accommodate) until someone pointed out we
could essentially abolosh HZ altogether, which seems like a much nice
solution to me.



  --cw
