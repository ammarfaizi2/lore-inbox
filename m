Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277803AbRKFEPB>; Mon, 5 Nov 2001 23:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281450AbRKFEOv>; Mon, 5 Nov 2001 23:14:51 -0500
Received: from zero.tech9.net ([209.61.188.187]:27151 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S277803AbRKFEOe>;
	Mon, 5 Nov 2001 23:14:34 -0500
Subject: Re: kernel 2.4.14 compiling fail for loop device
From: Robert Love <rml@tech9.net>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Terminator <jimmy@mtc.dhs.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E290D3DA-D26B-11D5-A0A2-00306569F1C6@haque.net>
In-Reply-To: <E290D3DA-D26B-11D5-A0A2-00306569F1C6@haque.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.05.15.31 (Preview Release)
Date: 05 Nov 2001 23:14:40 -0500
Message-Id: <1005020081.897.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-05 at 23:08, Mohammad A. Haque wrote:
> Safe to remove those two lines from loop.c? Other calls of deactive_page 
> were just removed it seemed.

Yes, it is.  I am sure that will be exactly what 2.4.15-pre1 does.

	Robert Love

