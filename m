Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbSJWAcG>; Tue, 22 Oct 2002 20:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262295AbSJWAcG>; Tue, 22 Oct 2002 20:32:06 -0400
Received: from pc132.utati.net ([216.143.22.132]:13185 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S262276AbSJWAcF> convert rfc822-to-8bit; Tue, 22 Oct 2002 20:32:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: "Richard J Moore" <richardj_moore@uk.ibm.com>
Subject: Re: dynamic probes vs kprobes
Date: Tue, 22 Oct 2002 14:38:11 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <OF2BA226A6.4D51ABFF-ON80256C5A.004810FC@portsmouth.uk.ibm.com>
In-Reply-To: <OF2BA226A6.4D51ABFF-ON80256C5A.004810FC@portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210221438.11967.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 October 2002 08:13, Richard J Moore wrote:
> Rob, are you happy with the distinction between dprobes and kprobes?

I'm just trying to understand the distinction.  The 2.5 status list had 
dprobes in the "ready" state, and my list started from there.

> We are
> not proposing dprobes for 2.5 but rather kprobes + as many of the
> incremental patches that Vamsi posted earlier. Altogether these amount to
> the same thing as dprobes. All of these patches will be available from our
> website.
>
> If on the other hand, if  Linus wishes to integrate dprobes then we shan't
> be disappointed :-)

So this is a two-level thing, with a baseline merge level that's independently 
useful, plus a full functionality merge that's dependent on the baseline?

I'll try to clarify in my list then.

Could you send me a URL to the separate patches?  Right now, the page I have 
has a download link for a tarball:

http://www-124.ibm.com/developerworks/opensource/linux/projects/dprobes/releases/dprobes-v3.6.3.tar.gz

If I understand the relationship between kprobes and dprobes correctly, it 
would be nice to have a standalone kprobes patch URL, and a second "dprobes 
on top of that" URL.

> Richard
> RAS Project Lead - IBM Linux Technology Centre

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
