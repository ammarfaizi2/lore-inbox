Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbUA3XQO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 18:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbUA3XQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 18:16:14 -0500
Received: from mail46-s.fg.online.no ([148.122.161.46]:14230 "EHLO
	mail46-s.fg.online.no") by vger.kernel.org with ESMTP
	id S264428AbUA3XQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 18:16:10 -0500
To: linux-kernel@vger.kernel.org
Subject: conformance, compliance and compatibility
From: Esben Stien <executiv@online.no>
Date: 30 Jan 2004 23:49:01 +0100
Message-ID: <87isitf3xe.fsf@online.no>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remember to have read that ISO has standardized on using
conformance for everything that is conforming to a specific
standard but I can't find it again. Anyone know where I could
look?

AFAIK, this is my understanding of these words

Conformance has a deep root different meaning than compliance,
but today that difference is not clear. However, ISO has
standardized on using the word conformance and not compliance
when saying something conforms to a standard. 

Compatibility is for hardware. You can say that a specific
piece of hardware is compatible with another piece of hardware
cause it speaks the same protocol. Compatibility is a way of
saying that two components uses the same interfaces. 

You can not call a system unix today, cause unix today is a
standard. The last unix was sysv. You can however say a system
is conforming to unix (iso posix unix)(ieee 1003.1), so it is a
unix conformant system. (to be technically correct). 

Is there any document that clarifies these words better. I'm
looking for some official documentation from a standards body
like ISO, IEC etc. 

I also see the words comformance and compliance used
interchangably in RFC's,  but to my knowledge I think I remember
that RFC's where also supposed to be using conformance 

-- 
b0ef

