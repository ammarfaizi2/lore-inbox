Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282883AbRK0JI0>; Tue, 27 Nov 2001 04:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282888AbRK0JIR>; Tue, 27 Nov 2001 04:08:17 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:21779 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S282883AbRK0JIB>; Tue, 27 Nov 2001 04:08:01 -0500
Message-ID: <3C0357B1.BA781012@idb.hist.no>
Date: Tue, 27 Nov 2001 10:06:57 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.1-pre1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Alex Riesen <riesen@synopsys.COM>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 alsa 0.5.12 mixer ioctl problem
In-Reply-To: <HKEMJNBMMEMMAEHPEBGNCEBNCBAA.riesen@synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:
> 
> Hi, all
> 
> just tried to compile the mentioned alsa drivers under 2.4.16.
> Mixer doesnt work, yes. It compiles, installs, loads. And
> any program trying to open mixer (through libasound) get EINVAL.
> 
> All is compiled with gcc-2.95.3,
> single CPU, with APIC (is any sense to enable it on
> uniprocessors?).
> 
> Does anybody know what to do about it?
>
I recommend getting ALSA 0.9.0beta9.   It works
well with 2.4.15 and 2.5.1-pre1, so it'll probably
work with 2.4.16 too.

Helge Hafting
