Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSHIUS2>; Fri, 9 Aug 2002 16:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSHIUS2>; Fri, 9 Aug 2002 16:18:28 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:48097 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315734AbSHIUS1>;
	Fri, 9 Aug 2002 16:18:27 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15700.9328.817832.974840@napali.hpl.hp.com>
Date: Fri, 9 Aug 2002 13:22:08 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>, linux-kernel@vger.kernel.org
Subject: Re: klibc development release
In-Reply-To: <3D541E2C.3010000@zytor.com>
References: <aivdi8$r2i$1@cesium.transmeta.com>
	<200208090934.g799YVZe116824@d12relay01.de.ibm.com>
	<200208091754.g79HsJkN058572@d06relay02.portsmouth.uk.ibm.com>
	<3D541018.4050004@zytor.com>
	<15700.4689.876752.886309@napali.hpl.hp.com>
	<3D541E2C.3010000@zytor.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 09 Aug 2002 12:55:24 -0700, "H. Peter Anvin" <hpa@zytor.com> said:

  HPA> You mean alpha calls umount2() "umount" and umount()
  HPA> "oldumount"?

Yes.

	--david
