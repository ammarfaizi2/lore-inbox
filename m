Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264947AbTLCP2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264950AbTLCP23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:28:29 -0500
Received: from main.gmane.org ([80.91.224.249]:19104 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264947AbTLCP22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:28:28 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.6.0-t11 /proc/<xserver pid>/status question (VmLck > 4TB)
Date: Wed, 03 Dec 2003 16:28:25 +0100
Message-ID: <yw1x8yltudie.fsf@kth.se>
References: <20031203161505.475f1bad.martin.zwickel@technotrend.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:9Ebo6d2zF7yCOcw2aklhIIZTIwM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Zwickel <martin.zwickel@technotrend.de> writes:

> Hi there,
>
> I have a small question:
>
> If I look into the "/proc/<xserver pid>/status" file, there is a VmLck with a
> 4TeraByte number.
>
> Is that normal?
>
> VmLck:  4294967292 kB

FWIW, that is -4 as an unsigned 32-bit number.

> Most other processes have 0kb.

My X shows 0.  I have a SiS chip.

-- 
Måns Rullgård
mru@kth.se

