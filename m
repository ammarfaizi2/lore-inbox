Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283588AbRLJHFJ>; Mon, 10 Dec 2001 02:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283467AbRLJHE7>; Mon, 10 Dec 2001 02:04:59 -0500
Received: from zero.tech9.net ([209.61.188.187]:41734 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S283055AbRLJHEr>;
	Mon, 10 Dec 2001 02:04:47 -0500
Subject: Re: [PATCH] fully preemptible kernel
From: Robert Love <rml@tech9.net>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, kpreempt-tech@lists.sourceforge.net
In-Reply-To: <01121008545000.01013@manta>
In-Reply-To: <1007930466.11789.2.camel@phantasy> 
	<01121008545000.01013@manta>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 10 Dec 2001 02:03:53 -0500
Message-Id: <1007967834.878.30.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-10 at 05:54, vda wrote:

> I reported a problem with preemptible 2.4.13 and Samba server (oops, problems 
> with creation of files from win clients).
> Is this issue addressed?

No, because I could not reproduce it.  Could you see if it occurs on the
current kernel with the current patch?  If so, send me the relevant
information.

	Robert Love

