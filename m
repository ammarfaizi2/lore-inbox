Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131712AbQKCUbJ>; Fri, 3 Nov 2000 15:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131689AbQKCUa7>; Fri, 3 Nov 2000 15:30:59 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:16590 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131749AbQKCUap>; Fri, 3 Nov 2000 15:30:45 -0500
From: Christoph Rohland <cr@sap.com>
To: Jonathan George <Jonathan.George@trcinc.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Thrash reduction & RE: 2.4.0-test10 Sluggish After Load
In-Reply-To: <790BC7A85246D41195770000D11C56F21C848A@trc-tpaexc01.trcinc.com>
Organisation: SAP LinuxLab
Date: 03 Nov 2000 21:30:35 +0100
In-Reply-To: Jonathan George's message of "Fri, 3 Nov 2000 09:51:48 -0500"
Message-ID: <qwwofzw6bo4.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Fri, 3 Nov 2000, Jonathan George wrote:
> I wonder how much of that memory is actually being used by your
> processes.  My guess is that it's not the whole thing (unless you
> are running on a 64bit architecture).

Yes of course it is using the whole memory. That's what the highmem
stuff is all about.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
