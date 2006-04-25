Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWDYLF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWDYLF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 07:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWDYLF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 07:05:58 -0400
Received: from uproxy.gmail.com ([66.249.92.168]:34986 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751518AbWDYLF6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 07:05:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bHG2ItyE70o33IxGAersO3xUTacIlUcsHiiE24bHjt9VLDQcJWk9oMLXQkbrV6SCgsTExmTaW9o6qOT50R/Pkw9XDvNDWqM5VUvkq14zDEObQYcoJ7HwFttfNX+BVnQnhh+RfHvUxCKLbRV1/8a5QUGOuLeKUEuHmIhL0dFRC+s=
Message-ID: <40cb3b290604250405q1ddd77b5vef1e4aadd9ebd071@mail.gmail.com>
Date: Tue, 25 Apr 2006 13:05:56 +0200
From: "Charles Majola" <chmj@rootcore.co.za>
To: linux-kernel@vger.kernel.org
Subject: Re: EMT64T build error
In-Reply-To: <p73wtdd9b5u.fsf@bragg.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <40cb3b290604250350n60c91bfapae0a622cfdbb731d@mail.gmail.com>
	 <p73wtdd9b5u.fsf@bragg.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shoot, my bad, thanks

On 25 Apr 2006 12:55:57 +0200, Andi Kleen <ak@suse.de> wrote:
> "Charles Majola" <chmj@rootcore.co.za> writes:
>
> > When i try to build 2.6.17-rc2 on amd64-generic machine with gcc 4.0.3
> > (Ubuntu 64 bit) I get the following error (i386 builds fine)..
>
> Do a make distclean after saving your .config.
>
> -Andi
>
