Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWAWW55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWAWW55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWAWW55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:57:57 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:22332 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964971AbWAWW54 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:57:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YJHrbZhimFYmrLjBvrltC6l3PXOUsIJTqe+qKEM+Zkh0q2fC8ll6miNEGDpgzfyGcU6lY/CqlCiAKUNB5fCKsTeM6+MI606RejmEqSA7obHIuHjbj4dEdulpKmSLldNBjsoT7iu/mpRt3VBsGBiZiZSziuqmAUlQfLJNESr4Auo=
Message-ID: <728201270601231457v14adc0a9t19166ddb330be0e4@mail.gmail.com>
Date: Mon, 23 Jan 2006 16:57:32 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: Michael Loftis <mloftis@wgops.com>
Subject: Re: [RFC] VM: I have a dream...
Cc: "Barry K. Nathan" <barryn@pobox.com>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <280A351A008C409CEF43A734@dhcp-2-206.wgops.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601212108.41269.a1426z@gawab.com>
	 <986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>
	 <E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
	 <728201270601230705k25e6890ejd716dbfc393208b8@mail.gmail.com>
	 <280A351A008C409CEF43A734@dhcp-2-206.wgops.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/06, Michael Loftis <mloftis@wgops.com> wrote:

> You missed the point.  The kernel in OS X maintains creation and use of
> these files automatically.  The point wasn't oh wow multiple files' it was
> that it creates them on the fly.  I just posted back with the apparent new
> method that's being used.  I'm not sure if the 512MB number continues or if
> the next file will be 1Gb or another 512M.  Or of memory size affects it or
> not.
>
> I'm sure developer.apple.com or apple darwin pages have the information
> somewhere.
>

What do you mean by automatically? As I understand there is no such
thing .If there is a task it has to be done by someone. Something is
done automatically from application point of done because kernel takes
care of that. So if  creation and use of swap  files  is done
automatically then who does it? Is it done by hardware?
