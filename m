Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293704AbSCAIaM>; Fri, 1 Mar 2002 03:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310401AbSCAI0X>; Fri, 1 Mar 2002 03:26:23 -0500
Received: from r198m97.cybercable.tm.fr ([195.132.198.97]:54276 "EHLO lsinitam")
	by vger.kernel.org with ESMTP id <S310403AbSCAIQz> convert rfc822-to-8bit;
	Fri, 1 Mar 2002 03:16:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Laurent <laurent@augias.org>
To: Alexander Viro <viro@math.psu.edu>, Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Subject: Re: read_proc issue
Date: Fri, 1 Mar 2002 09:18:16 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Val Henson <val@nmt.edu>,
        "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0203010245150.2886-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0203010245150.2886-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16giF7-0000Gc-00@lsinitam>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We already have better mechanism.  Let ->proc_read() die, it's an ugly
> kludge, breeding overcomplicated code and buffer overflows.

What better mechanism ??

-- 
Laurent Sinitambirivoutin
laurent@augias.org
