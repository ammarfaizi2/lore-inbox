Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132559AbRDEF3n>; Thu, 5 Apr 2001 01:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132561AbRDEF3d>; Thu, 5 Apr 2001 01:29:33 -0400
Received: from samar.sasken.com ([164.164.56.2]:57986 "EHLO samar.sasi.com")
	by vger.kernel.org with ESMTP id <S132559AbRDEF3V>;
	Thu, 5 Apr 2001 01:29:21 -0400
Message-ID: <3ACC4F5B.5A1D2923@sasken.com>
Date: Thu, 05 Apr 2001 16:26:27 +0530
From: Manoj Sontakke <manojs@sasken.com>
Organization: Sasken Communication Technologies Limited.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: which gcc version?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
	I am getting linker error "undefined reference to __divdi3".
This is because c = a/b; where a,b,c are of type "long long"
I understand this is gcc problem.
	I am doing this on a pentium with gcc -v = egcs-2.91.66

Thanks for all the help.

Manoj
