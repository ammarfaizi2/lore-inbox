Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272288AbRH3Psa>; Thu, 30 Aug 2001 11:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272289AbRH3PsU>; Thu, 30 Aug 2001 11:48:20 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:38671 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id <S272288AbRH3PsN>;
	Thu, 30 Aug 2001 11:48:13 -0400
Date: Thu, 30 Aug 2001 11:46:19 -0400 (EDT)
From: Tester <tester@videotron.ca>
X-X-Sender: <Tester@TesterTop.PolyDom>
To: <linux-kernel@vger.kernel.org>
Subject: Bizzare crashes on IBM Thinkpad A22e
Message-ID: <Pine.LNX.4.33.0108301139310.8245-100000@TesterTop.PolyDom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just received an IBM Thinkpad A22e. Using kernel 2.4.2-2 (redhat 7.1
version) or the stock 2.4.4 or 2.4.9 (they all exhibit the same problem).
When I use any of the APM functions or any of the thinkpad keys (volume
keys and Fn-Fx keys.. for suspend and even display brightness), the whole
system freezes without any other indication. This is using a kernel with
APM compiled it, but without any other option. If I compile in ACPI
instead of APM, it freezes even before the kernel is done booting. But, it
worked perfectly well with the 2.2.19-2 kernel form Mandrake 7.2

Everything else seems to work fine... can anyone help?

-- 
Tester
tester@videotron.ca

Those who do not understand Unix are condemned to reinvent it, poorly. -- Henry Spencer

