Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265104AbSKEXi1>; Tue, 5 Nov 2002 18:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265105AbSKEXi1>; Tue, 5 Nov 2002 18:38:27 -0500
Received: from [212.18.235.100] ([212.18.235.100]:34313 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id <S265104AbSKEXi0>; Tue, 5 Nov 2002 18:38:26 -0500
Subject: Re: promise ide problem: missing disks
From: Justin Cormack <justin@street-vision.com>
To: Justin Cormack <justin@street-vision.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1036525756.2291.45.camel@lotte>
References: <1036525756.2291.45.camel@lotte>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 23:44:57 +0000
Message-Id: <1036539902.2291.48.camel@lotte>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 19:49, Justin Cormack wrote:
> I have a Promise Ultra133 IDE controller, and cannot get any drives to
> appear on the second channel under Linux. The controller says it finds
> the drive on the second channel on its bios screen, but Linux will not
> see it. This is with 2.4.20-pre9 and -rc1.

As a followup, this does not occur with default Redhat 8.0 kernel, so it
is a problem with the large changes in the driver since 2.4.18. Will try
to work out exactly when it broke.

