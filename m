Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271756AbRHURbt>; Tue, 21 Aug 2001 13:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271757AbRHURbk>; Tue, 21 Aug 2001 13:31:40 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:9106 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S271756AbRHURb3>; Tue, 21 Aug 2001 13:31:29 -0400
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hugh@veritas.com (Hugh Dickins), andersee@debian.org (Erik Andersen),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Subject: Re: [Patch] sysinfo compatibility
In-Reply-To: <E15ZBvd-0007q8-00@the-village.bc.nu>
Organisation: SAP LinuxLab
Date: 21 Aug 2001 19:30:13 +0200
Message-ID: <m3y9od1ftm.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, 21 Aug 2001, Alan Cox wrote:
>> before) to make that decision; but concluded it was helping callers
>> who might well go on to add ram+swap, and felt no overriding reason
>> to change that.  But you can certainly argue that's inappropriate
> 
> There are callers who did add ram + swap

And that's a reason to break compatibility?

Greetings
                Christoph

