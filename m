Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161207AbVIPRmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbVIPRmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbVIPRmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:42:21 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:61392 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161207AbVIPRmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:42:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=TBKwzt3oSIKpt7uUNJrCEJXiaMw5oIIdbL2Dsh1ntoRw3fSMNOUD2Cz6PutaAjo4zCP14cjA6xHwjrqg3GhCfQ0hl3TGWucsFSAUjDLU08vWLySoJWy+girf5eZ11P42nWwAKptuid/ZLWuRJJTVCI5ROA3O63aWQm8oZenmLxQ=
Date: Fri, 16 Sep 2005 21:52:37 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Nix <nix@esperi.org.uk>
Cc: fawadlateef@gmail.com, ivan.korzakow@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: best way to access device driver functions
Message-ID: <20050916175235.GA28546@mipter.zuzino.mipt.ru>
References: <a5986103050915004846d05841@mail.gmail.com> <1e62d137050915010361d10139@mail.gmail.com> <a598610305091505184a8aa8fd@mail.gmail.com> <1e62d13705091508391832f897@mail.gmail.com> <87mzmduq1h.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mzmduq1h.fsf@amaterasu.srvr.nix>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 01:59:22PM +0100, Nix wrote:
> Quick! What parameters does the CCISS_PASSTHRU32 ioctl() expect?)

Added to Documentation/ioctl-mess.txt, thanks. ;-)

