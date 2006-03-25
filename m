Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWCYP0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWCYP0y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 10:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWCYP0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 10:26:54 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:21393 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751425AbWCYP0y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 10:26:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F6nD4+idph9F8AG4v9OlqqGXwtXEAOAKF54Tc2IveskIj3QBojHieCjxgS4PsdNoe+besexILK98kuUn/lOLp0GGtDwNtlJJNeXffRNIwzrCxhwQBZtucIBW+uL7tEsRuF5yh/e9bcUngSF3/rhkIFpPSx2DC0iTY6TGhCZjohc=
Message-ID: <489ecd0c0603250726l118f622asb77d244ef8c0c129@mail.gmail.com>
Date: Sat, 25 Mar 2006 23:26:49 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [PATCH] Fix bug: flat binary loader doesn't check fd table full
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060324205337.d7d81d73.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0603222310j3f2b9804k30bca1adce33804d@mail.gmail.com>
	 <20060322234652.10f6afee.akpm@osdl.org>
	 <489ecd0c0603230115h4dd2b16fg54cfd97739a8b339@mail.gmail.com>
	 <20060323011718.7f34a282.akpm@osdl.org>
	 <20060324205337.d7d81d73.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/06, Paul Jackson <pj@sgi.com> wrote:
> > >   Anyone knows how to avoid "tab to space" converting in gmail?
> >
> > If I knew, I'd put it in my .signature :(
>
> If you use sendpatchset:
>
>   http://www.speakeasy.org/~pj99/sgi/sendpatchset
>
> with the gmail SMTP server "smtp.gmail.com" you can send patches from
> your gmail account without tab destruction.
>
> The documentation for sendpatchset is within the script.  Grep for
> 'gmail' in the script to see where to hack in your gmail account and
> password (low tech configuration ;)
  Thank you for your help. But my problem is that I can only access 80
and 443 ports behind the company firewall :(. So I guess that doesn't
work for me.

  For now I'll put the patch both in the mail text and as the
attachment, so maintainers can use the attached right-formatted patch
and other can also reply my patch in the text. Andrew, is it
acceptable?

  Any google guy here? Please, add this feature in gmail...

--
Best regards,
Luke Yang
luke.adi@gmail.com
