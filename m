Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281484AbRLDRWG>; Tue, 4 Dec 2001 12:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281645AbRLDRUy>; Tue, 4 Dec 2001 12:20:54 -0500
Received: from t2.redhat.com ([199.183.24.243]:6127 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S281555AbRLDRTj>; Tue, 4 Dec 2001 12:19:39 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011204120835.D16578@thyrsus.com> 
In-Reply-To: <20011204120835.D16578@thyrsus.com>  <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com> <20011204140050.A10691@caldera.de> <20011204081640.A12658@thyrsus.com> <20011204142958.A14069@caldera.de> <20011204111115.A15160@thyrsus.com> <19642.1007484062@redhat.com> 
To: esr@thyrsus.com
Cc: Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Dec 2001 17:19:28 +0000
Message-ID: <23891.1007486368@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  I'm listening...what can I do for you?

Simply assure me that I don't have to scan every line of the CML2 files for
such changes, and that you'll make a reasonable effort to make the first set
of CML2 rules match the existing CML1 behaviour, without introducing any
controversial changes.

Submit the stuff you know is less popular, like hiding options without help 
text, later - and we can argue about them at the time. 

--
dwmw2


