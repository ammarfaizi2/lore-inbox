Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbTEBRbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 13:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbTEBRbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 13:31:09 -0400
Received: from pop.gmx.net ([213.165.64.20]:27230 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261243AbTEBRbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 13:31:08 -0400
Message-ID: <3EB2AE3D.2080100@gmx.net>
Date: Fri, 02 May 2003 19:43:25 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: John Jasen <jjasen@realityfailure.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Did the SCO Group plant UnixWare source in the Linux kernel?
References: <Pine.LNX.4.44.0305021326390.23347-100000@bushido>
In-Reply-To: <Pine.LNX.4.44.0305021326390.23347-100000@bushido>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Jasen wrote:
> On Fri, 2 May 2003, Carl-Daniel Hailfinger wrote:
> 
> 
>>whois has worked right since then for all .org domains. Really.

A patched whois, that is. Sorry I forgot to point that out.

> No, not really. There are a few .org names that they still don't spit out 
> anything for.
> 
> Really. I admin them. Really.

I believe you. With an unpatched whois, no .org domain should ever be
found. In absence of a patch, please try
whois -h whois.pir.org <domainname.org>
instead of whois <domainname.org> . That should cure the problem.

> I did check on the availability of scoloses.org, and my registrar seems to 
> think its available, so I cede the point.

Thanks anyway for pointing out the problem with unpatched whois. I guess
my first comment was a bit misleading in light of that.

HTH,
Carl-Daniel

